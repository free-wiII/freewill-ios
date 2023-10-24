//
//  LoginViewModel.swift
//  Synergy
//
//  Created by 이승기 on 10/15/23.
//

import SwiftUI
import Combine

import AuthenticationServices

import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

import GoogleSignIn
import UIKit

import Moya

final class LoginViewModel: NSObject, ObservableObject {
  
  // MARK: - Properties
  
  private let loginService = MoyaProvider<LoginAPI>()
  private var cancellables = Set<AnyCancellable>()
  
  enum LoginError: Error {
    case failToSignUp
    case failToSignIn
  }
  
  enum LoginRequestState: Equatable {
    case idle
    case success
    case loading
    case failure(LoginError)
  }
  
  @Published private(set) var loginRequestState = LoginRequestState.idle
  
  
  // MARK: - Public
  
  public func requestAppleLogin() {
    let request = ASAuthorizationAppleIDProvider().createRequest()
    request.requestedScopes = [.fullName, .email]
    
    let controller = ASAuthorizationController(authorizationRequests: [request])
    controller.delegate = self
    controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
    controller.performRequests()
  }
  
  public func requestKakaoLogin() {
    loginRequestState = .loading
    
    if UserApi.isKakaoTalkLoginAvailable() {
      UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
        if let error = error {
          print(error)
          self?.loginRequestState = .failure(.failToSignUp)
        } else {
          UserApi.shared.me { [weak self] user, error in
            guard let idToken = oauthToken?.idToken,
                  let name = user?.properties?["nickname"] else {
              self?.loginRequestState = .failure(.failToSignUp)
              return
            }
            
            self?.singUp(provider: .kakao, idToken: idToken, name: name, email: user?.kakaoAccount?.email)
          }
        }
      }
    }
  }
  
  public func requestGoogleLogin(rootViewController: UIViewController) {
    loginRequestState = .loading
    
    GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] result, error in
      if let error = error {
        print(error)
        self?.loginRequestState = .failure(.failToSignUp)
        return
      }
      
      guard let result = result,
            let idToken = result.user.idToken?.tokenString,
            let name = result.user.profile?.name,
            let email = result.user.profile?.email else {
        self?.loginRequestState = .failure(.failToSignUp)
        return
      }
      
      self?.singUp(provider: .google, idToken: idToken, name: name, email: email)
    }
  }
  
  
  // MARK: - Private
  
  private func singUp(provider: LoginProvider, idToken: String, name: String, email: String?) {
    loginRequestState = .loading
    
    loginService.requestPublisher(.signUp(provider: provider, idToken: idToken, name: name, email: email))
      .subscribe(on: DispatchQueue.global())
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        switch completion {
        case .failure(let error):
          print(error)
          self?.loginRequestState = .failure(.failToSignUp)
        case .finished:
          break
        }
      } receiveValue: { [weak self] response in
        if 200..<300 ~= response.statusCode {
          do {
            let signUpResponse = try JSONDecoder().decode(SignUpResponse.self, from: response.data)
            // Response로 받은 id, access, refresh 토큰 키체인에 저장
            let tokenKeyChain = TokenKeyChain()
            tokenKeyChain.create(tokenType: .idToken, value: idToken)
            tokenKeyChain.create(tokenType: .accessToken, value: signUpResponse.data.accessToken)
            tokenKeyChain.create(tokenType: .refreshToken, value: signUpResponse.data.refreshToken)
            self?.loginRequestState = .success
          } catch {
            self?.loginRequestState = .failure(.failToSignUp)
          }
        } else {
          self?.loginRequestState = .failure(.failToSignUp)
        }
      }
      .store(in: &cancellables)
  }
  
  private func singIn(provider: LoginProvider) {
    // 키체인에 저장한 access 토큰 불러와서 사용
    let tokenKeyChain = TokenKeyChain()
    guard let idToken = tokenKeyChain.read(tokenType: .accessToken) else {
      loginRequestState = .failure(.failToSignIn)
      return
    }
    
    loginService.requestPublisher(.signIn(provider: provider, idToken: idToken))
      .subscribe(on: DispatchQueue.global())
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        switch completion {
        case .failure(let error):
          print(error)
          self?.loginRequestState = .failure(.failToSignIn)
        case .finished:
          break
        }
      } receiveValue: { [weak self] response in
        if 200..<300 ~= response.statusCode {
          do {
            let signInResponse = try JSONDecoder().decode(SignInResponse.self, from: response.data)
            // Response로 받은 access, refresh 토큰 갱신
            let tokenKeyChain = TokenKeyChain()
            tokenKeyChain.create(tokenType: .accessToken, value: signInResponse.data.accessToken)
            tokenKeyChain.create(tokenType: .refreshToken, value: signInResponse.data.refreshToken)
            self?.loginRequestState = .success
          } catch {
            self?.loginRequestState = .failure(.failToSignIn)
          }
        } else {
          self?.loginRequestState = .failure(.failToSignIn)
        }
      }
      .store(in: &cancellables)
  }
}

extension LoginViewModel: ASAuthorizationControllerDelegate {
  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
      loginRequestState = .failure(.failToSignUp)
      return
    }
    
    if let email = credential.email {
      // 회원가입
      guard let idToken = String(data: credential.identityToken!, encoding: .utf8),
            let name = credential.fullName,
            let email = credential.email else {
        loginRequestState = .failure(.failToSignUp)
        return
      }
      
      singUp(provider: .apple, idToken: idToken, name: "\(name.familyName ?? "") \(name.givenName ?? "")", email: email)
    } else {
      // 로그인
      singIn(provider: .apple)
    }
  }
  
  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    loginRequestState = .failure(.failToSignIn)
  }
}

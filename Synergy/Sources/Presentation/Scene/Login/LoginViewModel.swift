//
//  LoginViewModel.swift
//  Synergy
//
//  Created by 이승기 on 10/15/23.
//

import SwiftUI

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
  
  enum LoginError: Error {
    case failToLogin
    case failToGetUserInfo
  }
  
  enum LoginRequestState {
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
          self?.loginRequestState = .failure(.failToLogin)
        } else {
          UserApi.shared.me { [weak self] user, error in
            guard let idToken = oauthToken?.idToken,
                  let name = user?.kakaoAccount?.name else {
              self?.loginRequestState = .failure(.failToGetUserInfo)
              return
            }
            
            self?.loginService
              .request(.login(provider: .kakao,
                              idToken: idToken,
                              name: name,
                              email: user?.kakaoAccount?.email)) { result in
                switch result {
                case .success(let response):
                  if response.statusCode == 100 {
                    self?.loginRequestState = .success
                  } else {
                    self?.loginRequestState = .failure(.failToLogin)
                  }
                case .failure(let error):
                  print(error)
                  self?.loginRequestState = .failure(.failToLogin)
                }
              }
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
        self?.loginRequestState = .failure(.failToLogin)
        return
      }
      
      guard let result = result,
            let idToken = result.user.idToken?.tokenString,
            let name = result.user.profile?.name,
            let email = result.user.profile?.email else {
        self?.loginRequestState = .failure(.failToGetUserInfo)
        return
      }
      
      self?.loginService
        .request(.login(provider: .google,
                        idToken: idToken,
                        name: name,
                        email: email)) { result in
          switch result {
          case .success(let response):
            if response.statusCode == 100 {
              self?.loginRequestState = .success
            } else {
              self?.loginRequestState = .failure(.failToLogin)
            }
          case .failure(let error):
            print(error)
            self?.loginRequestState = .failure(.failToLogin)
          }
        }
    }
  }
}

extension LoginViewModel: ASAuthorizationControllerDelegate {
  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
      loginRequestState = .failure(.failToLogin)
      return
    }
    
    if let email = credential.email {
      print(email)
    } else {
      guard let idToken = String(data: credential.identityToken!, encoding: .utf8),
            let namePrefix = credential.fullName?.namePrefix,
            let nameSuffix = credential.fullName?.nameSuffix else {
        loginRequestState = .failure(.failToLogin)
        return
      }
      
      loginService.request(.login(provider: .apple,
                                  idToken: idToken,
                                  name: "\(namePrefix) \(nameSuffix)",
                                  email: credential.email)) { [weak self] result in
        switch result {
        case .success(let response):
          if response.statusCode == 100 {
            self?.loginRequestState = .success
          } else {
            self?.loginRequestState = .failure(.failToLogin)
          }
        case .failure(let error):
          print(error)
          self?.loginRequestState = .failure(.failToLogin)
        }
      }
    }
  }
  
  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    loginRequestState = .failure(.failToLogin)
  }
}

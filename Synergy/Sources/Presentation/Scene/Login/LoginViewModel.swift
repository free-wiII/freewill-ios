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

final class LoginViewModel: NSObject, ObservableObject {
  
  // MARK: - Properties
  
  
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
    if (UserApi.isKakaoTalkLoginAvailable()) {
      UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
        if let error = error {
          print(error)
        }
        else {
          _ = oauthToken
          UserApi.shared.me { user, error in
            print(user)
            print("🔑 kakao id token")
            print(oauthToken?.idToken)
          }
        }
      }
    }
  }
  
  public func requestGoogleLogin(rootViewController: UIViewController) {
    GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
      if let error {
        print(error)
        return
      }
      
      if let result {
        print(result.user.profile?.email, result.user.profile?.name)
        print("🔑 google id token")
        print(result.user.idToken)
      }
    }
  }
}

extension LoginViewModel: ASAuthorizationControllerDelegate {
  func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential else { return }
    
    if let email = credential.email {
      print(email)
    } else {
//      if let token = String(data: credential.identityToken ?? Data(), encoding: .utf8) {
//        let email = decode
//      }
      // idToken
      print("🔑 apple id token")
      print(String(data: credential.identityToken!, encoding: .utf8))
    }
  }
  
  func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    // handle error
  }
}

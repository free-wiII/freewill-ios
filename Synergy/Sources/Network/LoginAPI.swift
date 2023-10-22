//
//  LoginAPI.swift
//  Synergy
//
//  Created by 이승기 on 10/18/23.
//

import Foundation
import Moya

enum LoginAPI {
  case signUp(provider: LoginProvider, idToken: String, name: String, email: String?)
  case signIn(provider: LoginProvider, accessToken: String)
}

extension LoginAPI: TargetType {
  var baseURL: URL {
    return URL(string: "https://prod.cafree.net")!
  }
  
  var path: String {
    switch self {
    case .signUp:
      return "/api/v1/auth/sign-up"
    
    case .signIn:
      return "/api/v1/auth/sign-in"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .signUp:
      return .post
    
    case .signIn:
      return .post
    }
  }
  
  var task: Moya.Task {
    switch self {
    case .signUp(let provider, let idToken, let name, let email):
      let singUpEntity = SignUpEntity(provider: provider, idToken: idToken, name: name, email: email)
      let singUpData = try! JSONEncoder().encode(singUpEntity)
      let signUpPart = MultipartFormData(provider: .data(singUpData), name: "signUpRequest", mimeType: "application/json")
      return .uploadMultipart([signUpPart])
    
    case .signIn(provider: let provider, accessToken: let accessToken):
      let signInEntity = SignInEntity(provider: provider, accessToken: accessToken)
      let signInData = try! JSONEncoder().encode(signInEntity)
      let singInPart = MultipartFormData(provider: .data(signInData), name: "signInRequest", mimeType: "application/json")
      return .uploadMultipart([singInPart])
    }
  }
  
  var headers: [String : String]? {
    return nil
  }
}

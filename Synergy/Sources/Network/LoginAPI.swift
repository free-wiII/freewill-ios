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
  case signIn(provider: LoginProvider, idToken: String)
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
      let signUpEntity = SignUpEntity(provider: provider, idToken: idToken, name: name, email: email)
      return .requestCustomJSONEncodable(signUpEntity, encoder: JSONEncoder())
    
    case .signIn(let provider, let idToken):
      let signInEntity = SignInEntity(provider: provider, idToken: idToken)
      return .requestCustomJSONEncodable(signInEntity, encoder: JSONEncoder())
    }
  }
  
  var headers: [String : String]? {
    return nil
  }
}

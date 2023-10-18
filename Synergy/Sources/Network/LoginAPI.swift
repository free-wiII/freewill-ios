//
//  LoginAPI.swift
//  Synergy
//
//  Created by 이승기 on 10/18/23.
//

import Foundation
import Moya

enum LoginAPI {
  case login(provider: LoginProvider, idToken: String, name: String, email: String?)
}

extension LoginAPI: TargetType {
  var baseURL: URL {
    return URL(string: "https://prod.cafree.net/")!
  }
  
  var path: String {
    switch self {
    case .login:
      return "/api/v1/auth/sign-up"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .login:
      return .post
    }
  }
  
  var task: Moya.Task {
    switch self {
    case .login(let provider, let idToken, let name, let email):
      let loginEntity = LoginEntity(provider: provider, idToken: idToken, name: name, email: email)
      let jsonPart = MultipartFormData(provider: .data(try! JSONEncoder().encode(loginEntity)),
                                       name: "signUpRequest",
                                       mimeType: "application/json")
      return .uploadMultipart([jsonPart])
    }
  }
  
  var headers: [String : String]? {
    switch self {
    case .login:
      return [
        "Content-Type": "multipart/form-data",
        "Accept": "application/json"
      ]
    }
  }
}

//
//  ProfileAPI.swift
//  Synergy
//
//  Created by 이승기 on 10/24/23.
//

import Foundation
import Moya

enum ProfileAPI {
  case profile(accessToken: String)
}

extension ProfileAPI: TargetType {
  var baseURL: URL {
    return URL(string: "https://prod.cafree.net")!
  }
  
  var path: String {
    switch self {
    case .profile:
      return "/api/v1/profiles"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .profile:
      return .get
    }
  }
  
  var task: Moya.Task {
    switch self {
    case .profile:
      return .requestPlain
    }
  }
  
  var headers: [String : String]? {
    switch self {
    case .profile(let accessToken):
      return ["Authorization": "Bearer \(accessToken)"]
    }
  }
}

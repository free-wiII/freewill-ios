//
//  FreeWillAPI.swift
//  freewill
//
//  Created by 이승기 on 2023/09/15.
//

import Foundation
import Moya

enum FreeWillAPI {
  case fetchFeed
}

extension FreeWillAPI: TargetType {
  
  var baseURL: URL {
    return URL(string: "https://www.google.com")!
  }
  
  var path: String {
    switch self {
    case .fetchFeed:
      return "/feed"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .fetchFeed:
      return .get
    }
  }
  
  var task: Moya.Task {
    switch self {
    case .fetchFeed:
      return .requestPlain
    }
  }
  
  var headers: [String : String]? {
    return nil
  }
  
  var sampleData: Data {
    switch self {
    case .fetchFeed:
      let url = Bundle.main.url(forResource: "feed_list", withExtension: "json")!
      return try! Data(contentsOf: url)
    }
  }
}

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
  case fetchCafeDetail
}

extension FreeWillAPI: TargetType {
  
  var baseURL: URL {
    return URL(string: "https://www.google.com")!
  }
  
  var path: String {
    switch self {
    case .fetchFeed:
      return "/feed"
      
    case .fetchCafeDetail:
      return "/cafeDetail"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .fetchFeed:
      return .get
      
    case .fetchCafeDetail:
      return .get
    }
  }
  
  var task: Moya.Task {
    switch self {
    case .fetchFeed:
      return .requestPlain
      
    case .fetchCafeDetail:
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
      
    case .fetchCafeDetail:
      let url = Bundle.main.url(forResource: "cafe_detail", withExtension: "json")!
      return try! Data(contentsOf: url)
    }
  }
}

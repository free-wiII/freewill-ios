//
//  SynergyAPI.swift
//  freewill
//
//  Created by 이승기 on 2023/09/15.
//

import Foundation
import Moya

enum SynergyAPI {
  case fetchFeed(page: Int)
  case fetchCafeDetail
  case fetchReviewList
}

extension SynergyAPI: TargetType {
  
  var baseURL: URL {
    return URL(string: "https://www.google.com")!
  }
  
  var path: String {
    switch self {
    case .fetchFeed:
      return "/feed"
      
    case .fetchCafeDetail:
      return "/cafeDetail"
      
    case .fetchReviewList:
      return "/reviewList"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .fetchFeed:
      return .get
      
    case .fetchCafeDetail:
      return .get
    
    case .fetchReviewList:
      return .get
    }
  }
  
  var task: Moya.Task {
    return .requestPlain
  }
  
  var headers: [String : String]? {
    return nil
  }
  
  var sampleData: Data {
    switch self {
    case .fetchFeed(let page):
      
      switch page {
      case 1:
        let url = Bundle.main.url(forResource: "feed_list1", withExtension: "json")!
        return try! Data(contentsOf: url)
      case 2:
        let url = Bundle.main.url(forResource: "feed_list2", withExtension: "json")!
        return try! Data(contentsOf: url)
      default:
        return Data()
      }
      
    case .fetchCafeDetail:
      let url = Bundle.main.url(forResource: "cafe_detail", withExtension: "json")!
      return try! Data(contentsOf: url)
    
    case .fetchReviewList:
      let url = Bundle.main.url(forResource: "review_list", withExtension: "json")!
      return try! Data(contentsOf: url)
    }
  }
}

//
//  BookmarkAPI.swift
//  freewill
//
//  Created by 이승기 on 2023/09/16.
//

import Foundation
import Combine
import Moya
import CombineMoya

enum BookmarkAPI {
  case fetchBookmarkGroup
  case fetchBookmark
}

extension BookmarkAPI: TargetType {
  var baseURL: URL {
    return URL(string: "https://www.google.com")!
  }
  
  var path: String {
    switch self {
    case .fetchBookmarkGroup:
      return "/path"
    
    case .fetchBookmark:
      return "/path"
    }
  }
  
  var method: Moya.Method {
    return .get
  }
  
  var task: Moya.Task {
    return .requestPlain
  }
  
  var headers: [String : String]? {
    return nil
  }
  
  var sampleData: Data {
    switch self {
    case .fetchBookmarkGroup:
      let url = Bundle.main.url(forResource: "bookmark_group_list", withExtension: "json")!
      return try! Data(contentsOf: url)
    
    case .fetchBookmark:
      let url = Bundle.main.url(forResource: "bookmark_list", withExtension: "json")!
      return try! Data(contentsOf: url)
    }
  }
}

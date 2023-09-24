//
//  RatingCriteria.swift
//  freewill
//
//  Created by 이승기 on 2023/09/08.
//

import UIKit

enum RatingCriteria: String, CaseIterable, Codable {
  case mood = "MOOD"
  case beverage = "BEVERAGE"
  case desert = "DESERT"
  case group = "GROUP"
  case quiet = "QUIET"
  case consent = "CONSENT"
  
  var shortDescription: String {
    switch self {
    case .mood:
      return "분위기가 좋은"
    case .beverage:
      return "음료가 맛있는"
    case .desert:
      return "디저트가 맛있는"
    case .group:
      return "모임공간이 있는"
    case .quiet:
      return "조용한"
    case .consent:
      return "콘센트가 많은"
    }
  }
  
  var description: String {
    switch self {
    case .mood:
      return "분위기가 좋아요"
    case .beverage:
      return "음료가 맛있어요"
    case .desert:
      return "디저트가 맛있어요"
    case .group:
      return "모임공간이 있어요"
    case .quiet:
      return "조용해요"
    case .consent:
      return "콘센트가 많아요"
    }
  }
  
  var emoji: String {
    switch self {
    case .mood:
      return "🕯️"
    case .beverage:
      return "☕️"
    case .desert:
      return "🍪"
    case .group:
      return "👥"
    case .quiet:
      return "🤫"
    case .consent:
      return "🔌"
    }
  }
}

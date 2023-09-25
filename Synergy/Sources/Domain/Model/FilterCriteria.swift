//
//  FilterCriteria.swift
//  Synergy
//
//  Created by 이승기 on 2023/09/07.
//

import Foundation

enum FilterCriteria: CaseIterable {
  case best
  case mood
  case beverage
  case desert
  case group
  case quiet
  case consent
  
  var description: String {
    switch self {
    case .best:
      return "🔥 많이 찾는"
    case .mood:
      return "🕯️ 분위기가 좋은"
    case .beverage:
      return "☕️ 음료가 맛있어요"
    case .desert:
      return "🍪 디저트가 맛있어요"
    case .group:
      return "👥 모임공간이 있어요"
    case .quiet:
      return "🤫 조용해요"
    case .consent:
      return "🔌 콘센트가 많아요"
    }
  }
}

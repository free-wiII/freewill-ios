//
//  TabItem.swift
//  Synergy
//
//  Created by 이승기 on 2023/09/06.
//

import UIKit

enum TabItem: CaseIterable, Hashable {
  case main
  case bookmark
  case myPage
  
  public var name: String {
    switch self {
    case .main:
      return "홈"
    case .bookmark:
      return "북마크"
    case .myPage:
      return "마이"
    }
  }
  
  public var image: UIImage {
    switch self {
    case .main:
      return R.image.house()!
    case .bookmark:
      return R.image.bookmark()!
    case .myPage:
      return R.image.person_circle()!
    }
  }
}

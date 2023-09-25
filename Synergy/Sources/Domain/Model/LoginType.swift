//
//  LoginType.swift
//  Synergy
//
//  Created by 이승기 on 2023/09/07.
//

import UIKit

enum LoginType {
  case kakao
  case google
  case apple
  
  var description: String {
    switch self {
    case .kakao:
      return "카카오 로그인"
    case .google:
      return "구글 로그인"
    case .apple:
      return "애플 로그인"
    }
  }
  
  var image: UIImage {
    switch self {
    case .kakao:
      return R.image.login_kakao()!
    case .google:
      return R.image.login_google()!
    case .apple:
      return R.image.login_apple()!
    }
  }
}

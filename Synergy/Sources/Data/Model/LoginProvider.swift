//
//  LoginProvider.swift
//  Synergy
//
//  Created by 이승기 on 10/16/23.
//

import Foundation

enum LoginProvider: String, Encodable {
  case kakao = "KAKAO"
  case google = "GOOGLE"
  case apple = "APPLE"
}

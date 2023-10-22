//
//  TokenData.swift
//  Synergy
//
//  Created by 이승기 on 10/22/23.
//

import Foundation

struct TokenData: Decodable {
  let accessToken: String
  let refreshToken: String
}

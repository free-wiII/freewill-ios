//
//  SignInResponse.swift
//  Synergy
//
//  Created by 이승기 on 10/22/23.
//

import Foundation

struct SignInResponse: Decodable {
  let status: String
  let message: String
  let data: TokenData
}

//
//  SignUpResponse.swift
//  Synergy
//
//  Created by 이승기 on 10/21/23.
//

import Foundation

struct SignUpResponse: Decodable {
  let status: String
  let message: String
  let data: TokenData
}

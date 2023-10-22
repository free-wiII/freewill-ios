//
//  SignUpEntity.swift
//  Synergy
//
//  Created by 이승기 on 10/18/23.
//

import Foundation

struct SignUpEntity: Encodable {
  let provider: LoginProvider
  let idToken: String
  let name: String
  let email: String?
}

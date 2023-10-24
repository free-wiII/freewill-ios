//
//  SignInEntity.swift
//  Synergy
//
//  Created by 이승기 on 10/22/23.
//

import Foundation

struct SignInEntity: Encodable {
  let provider: LoginProvider
  let idToken: String
}

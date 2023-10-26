//
//  ProfileEntity.swift
//  Synergy
//
//  Created by 이승기 on 10/24/23.
//

import Foundation

struct ProfileEntity: Decodable {
  let status: String
  let message: String
  let data: Data
  
  struct Data: Decodable {
    let imageUri: String?
    let nickname: String
    let email: String
  }
}

extension ProfileEntity {
  public func toDomain() -> Profile {
    return .init(imageUri: self.data.imageUri,
                 nickname: self.data.nickname,
                 email: self.data.email)
  }
}

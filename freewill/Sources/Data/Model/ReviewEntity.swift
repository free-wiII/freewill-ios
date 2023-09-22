//
//  ReviewEntity.swift
//  freewill
//
//  Created by 이승기 on 2023/09/22.
//

import Foundation

typealias ReviewListResponse = [ReviewEntity]

struct ReviewEntity: Decodable {
  let userId: Int
  let userName: String
  let image: String
  let content: String
  let likeCount: Int
}


// MARK: - To domain

extension ReviewEntity {
  func toDomain() -> Review {
    return .init(userId: userId,
                 userName: userName,
                 image: image,
                 content: content,
                 likeCount: likeCount)
  }
}

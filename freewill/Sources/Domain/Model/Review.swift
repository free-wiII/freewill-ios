//
//  Review.swift
//  freewill
//
//  Created by 이승기 on 2023/09/22.
//

import Foundation

struct Review: Decodable {
  let userId: Int
  let userName: String
  let image: String
  let content: String
  let likeCount: Int
}

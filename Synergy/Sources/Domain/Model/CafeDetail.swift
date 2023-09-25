//
//  CafeDetail.swift
//  Synergy
//
//  Created by 이승기 on 2023/09/22.
//

import Foundation

struct CafeDetail {
  let id: Int
  let name: String
  let images: [String]
  let likeCount: Int
  let isLiked: Bool
  let isBookmarked: Bool
  let ratings: [Rating]
  let location: Location
  let featuredReviews: [Review]
}

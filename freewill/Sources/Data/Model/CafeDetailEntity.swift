//
//  CafeDetailEntity.swift
//  freewill
//
//  Created by 이승기 on 2023/09/22.
//

import Foundation

struct CafeDetailEntity: Decodable {
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


// MARK: - To domain

extension CafeDetailEntity {
  func toDomain() -> CafeDetail {
    return .init(id: id,
                 name: name,
                 images: images, 
                 likeCount: likeCount,
                 isLiked: isLiked,
                 isBookmarked: isBookmarked,
                 ratings: ratings,
                 location: location,
                 featuredReviews: featuredReviews)
  }
}

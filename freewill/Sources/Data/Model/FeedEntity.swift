//
//  FeedEntity.swift
//  freewill
//
//  Created by 이승기 on 2023/09/15.
//

import Foundation

typealias FeedEntityResponse = [FeedEntity]

struct FeedEntity: Decodable {
  let id: Int
  let name: String
  let location: String
  let distance: Double
  let images: [String]
  let likeCount: Int
  let isLiked: Bool
  let isBookmarked: Bool
}


// MARK: - To Domain

extension FeedEntity {
  
  func toDomain() -> Feed {
    return Feed(id: id,
                name: name,
                location: location,
                distance: distance,
                images: images,
                likeCount: likeCount,
                isLiked: isLiked,
                isBookmarked: isBookmarked)
  }
}

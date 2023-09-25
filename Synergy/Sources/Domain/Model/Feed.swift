//
//  Feed.swift
//  Synergy
//
//  Created by 이승기 on 2023/09/15.
//

import Foundation

struct Feed: Identifiable {
  let id: Int
  let name: String
  let location: String
  let distance: Double
  let images: [String]
  let likeCount: Int
  let isLiked: Bool
  let isBookmarked: Bool
}

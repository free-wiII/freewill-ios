//
//  BookmarkEntity.swift
//  freewill
//
//  Created by 이승기 on 2023/09/16.
//

import UIKit

typealias BookmarkResponse = [BookmarkEntity]

struct BookmarkEntity: Decodable {
  let id: Int
  let title: String
  let location: String
  let images: [String]
}


// MARK: - To domain

extension BookmarkEntity {
  func toEntity() -> Bookmark {
    return .init(id: id,
                 title: title,
                 location: location,
                 images: images)
  }
}

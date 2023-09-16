//
//  BookmarkGroupEntity.swift
//  freewill
//
//  Created by 이승기 on 2023/09/16.
//

import Foundation

typealias BookmarkGroupResponse = [BookmarkGroupEntity]

struct BookmarkGroupEntity: Decodable {
  let id: Int
  let title: String
  let createdAt: String?
}


// MARK: - To domain

extension BookmarkGroupEntity {
  func toDomain() -> BookmarkGroup {
    return .init(id: id, title: title)
  }
}

//
//  BookmarkGroup.swift
//  freewill
//
//  Created by 이승기 on 2023/09/10.
//

import Foundation

struct BookmarkGroup: Identifiable {
  
  let id = UUID()
  let title: String
  let createdAt: Date
  
  static func ==(lhs: BookmarkGroup, rhs: BookmarkGroup) -> Bool {
    return lhs.id == rhs.id
  }
}

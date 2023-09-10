//
//  Bookmark.swift
//  freewill
//
//  Created by 이승기 on 2023/09/10.
//

import UIKit

struct Bookmark: Identifiable {
  let id = UUID()
  let title: String
  let location: String
  let images: [UIImage]
}

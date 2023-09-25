//
//  Rating.swift
//  Synergy
//
//  Created by 이승기 on 2023/09/22.
//

import Foundation

struct Rating: Codable {
  let criteria: RatingCriteria
  let score: Float
}

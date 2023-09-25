//
//  Location.swift
//  Synergy
//
//  Created by 이승기 on 2023/09/22.
//

import Foundation

struct Location: Decodable {
  let lng: Double
  let lat: Double
  let distance: Float
  let address: String
}

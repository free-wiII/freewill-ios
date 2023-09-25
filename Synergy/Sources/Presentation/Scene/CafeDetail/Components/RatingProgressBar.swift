//
//  RatingProgressBar.swift
//  Synergy
//
//  Created by 이승기 on 2023/09/22.
//

import SwiftUI

struct RatingProgressBar: View {
  
  // MARK: - Properties
  
  let maxValue: Float = 5
  let value: Float
  
  
  
  // MARK: - Views
  
  var body: some View {
    ZStack {
      Capsule()
        .fill(Color.fwGray30)
      
      GeometryReader { proxy in
        Capsule()
          .fill(Color.fwPink)
          .frame(width: proxy.size.width * CGFloat(value / maxValue))
      }
    }
    .frame(height: 6)
  }
}

#Preview {
  RatingProgressBar(value: 3)
}

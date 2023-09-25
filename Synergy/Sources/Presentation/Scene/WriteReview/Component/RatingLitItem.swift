//
//  RatingLitItem.swift
//  Synergy
//
//  Created by 이승기 on 2023/09/18.
//

import SwiftUI

struct RatingLitItem: View {
  
  // MARK: - Properties
  
  let rating: RatingCriteria
  @State private var ratingNumber = 3
  
  
  // MARK: - Views
  
  var body: some View {
    VStack(spacing: 12) {
      HStack {
        Text(rating.description)
          .font(.system(size: 17, weight: .bold))
          .foregroundStyle(Color.fwBlack)
        
        Spacer()
        
        Text("\(ratingNumber) 점")
          .font(.system(size: 17, weight: .bold))
          .foregroundStyle(Color.fwGray70)
      }
      
      HStack {
        minusButton()
        
        HStack {
          ForEach(0..<5) { index in
            Spacer()
            Text(rating.emoji)
              .font(.system(size: 28))
              .opacity(index < ratingNumber ? 1 : 0.3)
            Spacer()
          }
        }
        .frame(maxWidth: .infinity)
        
        plusButton()
      }
      .padding(.horizontal, 12)
      .padding(.top, 4)
      
      HStack {
        Text("불만족")
          .frame(width: 52)
        
        Spacer()
        
        Text("만족")
          .frame(width: 52)
      }
      .font(.system(size: 13))
      .foregroundStyle(Color.fwBlack)
    }
  }
  
  private func minusButton() -> some View {
    Button {
      if ratingNumber == 1 { return }
      ratingNumber -= 1
    } label: {
      Circle()
        .stroke(Color.fwGray30, lineWidth: 1)
        .overlay {
          Image(uiImage: R.image.minus()!)
            .resizable()
            .frame(width: 12, height: 12)
            .foregroundStyle(Color.fwBlack)
        }
        .frame(width: 28, height: 28)
    }
  }
  
  private func plusButton() -> some View {
    Button {
      if ratingNumber == 5 { return }
      ratingNumber += 1
    } label: {
      Circle()
        .stroke(Color.fwGray30, lineWidth: 1)
        .overlay {
          Image(uiImage: R.image.plus()!)
            .resizable()
            .frame(width: 12, height: 12)
            .foregroundStyle(Color.fwBlack)
        }
        .frame(width: 28, height: 28)
    }
  }
}

#Preview {
  RatingLitItem(rating: .beverage)
}

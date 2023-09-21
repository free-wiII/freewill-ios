//
//  WriteReviewView.swift
//  freewill
//
//  Created by 이승기 on 2023/09/18.
//

import SwiftUI

struct WriteReviewView: View {
  
  // MARK: - Properties
  
  @Environment(\.dismiss) private var dismiss
  
  @State private var reviewText = ""
  
  
  // MARK: - Views
  
  var body: some View {
    VStack(spacing: 0) {
      NavigationBar(leadingContent: {
        Button {
          dismiss()
        } label: {
          Image(uiImage: R.image.chevron_left()!)
            .resizable()
            .padding(8)
            .frame(width: 32, height: 32)
            .foregroundStyle(Color.fwBlack)
        }
      }, centerContent: {
        Text("방명록 작성하기")
          .font(.system(size: 17, weight: .bold))
          .foregroundStyle(Color.fwBlack)
      })
      
      ScrollView {
        VStack(spacing: 40) {
          ZStack(alignment: .init(horizontal: .leading, vertical: .top)) {
            TextEditor(text: $reviewText)
              .font(.system(size: 15))
              .foregroundStyle(Color.fwBlack)
              .tint(Color.fwBlack)
              .frame(maxWidth: .infinity, minHeight: 144)
              .padding(8)
            
            if reviewText.isEmpty {
              Text("솔직한 후기를 작성해 보세요")
                .padding(16)
                .font(.system(size: 15))
                .foregroundStyle(Color.fwGray40)
            }
            
            RoundedRectangle(cornerRadius: 12)
              .stroke(Color.fwGray40, lineWidth: 1)
          }
          
          ForEach(Array(RatingCriteria.allCases.enumerated()), id: \.offset) { _, rating in
            RatingLitItem(rating: rating)
          }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 16)
      }
      
      BottomContainerButton("제출", enabled: .constant(reviewText.isEmpty ? false : true)) {
        dismiss()
      }
    }
    .toolbar(.hidden, for: .navigationBar)
  }
}


// MARK: - Preview

#Preview {
  WriteReviewView()
}

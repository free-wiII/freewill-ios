//
//  ReviewListItem.swift
//  Synergy
//
//  Created by 이승기 on 2023/09/22.
//

import SwiftUI

struct ReviewListItem: View {
  
  // MARK: - Properties
  
  let review: Review
  
  
  // MARK: - Views
  
  var body: some View {
    HStack(alignment: .top, spacing: 12) {
      AsyncImage(url: URL(string: review.image)) { image in
        image
          .resizable()
      } placeholder: {
        Color.fwGray30
      }
      .frame(width: 38, height: 38)
      .clipShape(Circle())
      
      VStack(spacing: 4) {
        Text(review.userName)
          .font(.system(size: 13))
          .foregroundStyle(Color.fwGray60)
          .frame(maxWidth: .infinity, alignment: .leading)
        
        Text(review.content)
          .font(.system(size: 15))
          .foregroundStyle(Color.fwBlack)
          .frame(maxWidth: .infinity, alignment: .leading)
          .multilineTextAlignment(.leading)
          .lineLimit(5)
      }
      
      Button {
        // action
      } label: {
        VStack(spacing: 2) {
          Image(uiImage: R.image.thumbsup()!)
            .resizable()
            .foregroundStyle(Color.fwGray)
            .frame(width: 16, height: 16)
          
          Text(review.likeCount.description)
            .font(.system(size: 13, weight: .medium))
            .foregroundStyle(Color.fwBlack)
        }
        .padding(.vertical, 8)
      }
    }
  }
}

#Preview {
  let review = Review(userId: 0,
                      userName: "name",
                      image: "https://picsum.photos/300/300",
                      content: "디저트도 너무 맛있고 조용해서 공부하기 좋았어요!;jdskaf;lsadkfjs;lakfjdls;afdskfjaslkㄹㅇ니ㅏ머리안ㅁ러ㅣㅏㄴㅁㅇ러ㅣㅏㄴ러ㅣㅏㅁ너리마너",
                      likeCount: 231)
  return ReviewListItem(review: review)
}

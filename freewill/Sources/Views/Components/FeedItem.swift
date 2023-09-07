//
//  FeedItem.swift
//  freewill
//
//  Created by 이승기 on 2023/09/07.
//

import SwiftUI

struct FeedItem: View {
  
  // MARK: - Properties
  
  
  // MARK: - Views
  
  var body: some View {
    VStack(spacing: 0) {
      VStack(alignment: .leading, spacing: 2) {
        Text("title")
          .font(.system(size: 15, weight: .bold))
          .foregroundColor(Color.fwBlack)
          .frame(maxWidth: .infinity, alignment: .leading)
        
        Text("location")
          .font(.system(size: 13))
          .foregroundColor(Color.fwBlack)
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      .padding(.horizontal, 4)
      .frame(maxWidth: .infinity)
      
      ZStack {
        RoundedRectangle(cornerRadius: 12)
          .fill(Color.fwWhite)
        
        VStack {
          HStack {
            Spacer()
            
            HStack(spacing: 4) {
              Image(uiImage: R.image.route()!)
                .resizable()
                .frame(width: 16, height: 16)
              
              Text("00km")
                .font(.system(size: 13, weight: .medium))
            }
            .foregroundColor(Color.fwGray)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(BlurView())
            .cornerRadius(8)
          }
          
          Spacer()
        }
        .padding(8)
      }
      .aspectRatio(343/230, contentMode: .fit)
      .padding(.top, 8)
      .shadow(color: .black.opacity(0.1),
              radius: 20, x: 0, y: 4)
      
      HStack(spacing: 0) {
        HStack(spacing: 8) {
          Button {
            // action
          } label: {
            Image(uiImage: R.image.thumbsup()!)
              .resizable()
              .frame(width: 24, height: 24)
              .foregroundColor(Color.fwGray)
          }
          
          Text("추천 252")
            .font(.system(size: 13, weight: .bold))
            .foregroundColor(Color.fwGray)
        }
        .padding(.horizontal, 4)
        
        Spacer()
        
        Button {
          // action
        } label: {
          Image(uiImage: R.image.bookmark()!)
            .resizable()
            .padding(6)
            .frame(width: 32, height: 32)
            .foregroundColor(Color.fwGray)
        }
      }
      .padding(.horizontal, 4)
      .padding(.top, 16)
    }
  }
}


// MARK: - Preview

struct FeedItem_Previews: PreviewProvider {
  static var previews: some View {
    FeedItem()
  }
}

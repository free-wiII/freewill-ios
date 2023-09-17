//
//  CafeListItem.swift
//  freewill
//
//  Created by 이승기 on 2023/09/07.
//

import SwiftUI

struct CafeListItem: View {
  
  // MARK: - Properties
  
  let feed: Feed
  @State private var selectedImage: Int = 0
  
  @State private var isSaveCafeViewShown = false
  
  
  // MARK: - Views
  
  var body: some View {
    VStack(spacing: 0) {
      VStack(alignment: .leading, spacing: 2) {
        Text(feed.name)
          .font(.system(size: 15, weight: .bold))
          .foregroundColor(Color.fwBlack)
          .frame(maxWidth: .infinity, alignment: .leading)
        
        Text(feed.location)
          .font(.system(size: 13))
          .foregroundColor(Color.fwBlack)
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      .padding(.horizontal, 4)
      .frame(maxWidth: .infinity)
      
      ZStack {
        TabView {
          ForEach(Array(feed.images.enumerated()), id: \.offset) { _, imageUrl in
            AsyncImage(url: URL(string: imageUrl)) { image in
              image
                .resizable()
                .aspectRatio(contentMode: .fill)
            } placeholder: {
              ProgressView()
            }
          }
        }
        .tabViewStyle(.page)
        .background(Color.fwWhite)
        .cornerRadius(12)
        
        VStack {
          HStack {
            Spacer()
            
            HStack(spacing: 4) {
              Image(uiImage: R.image.route()!)
                .resizable()
                .frame(width: 16, height: 16)
              
              Text("\(String(format: "%.2f", feed.distance)) km")
                .font(.system(size: 13, weight: .medium))
            }
            .foregroundColor(Color.fwBlack)
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
            Image(uiImage: feed.isLiked ? R.image.thumbsup_filled()! : R.image.thumbsup()!)
              .resizable()
              .frame(width: 24, height: 24)
              .foregroundColor(feed.isLiked ? Color.fwPink : Color.fwGray)
          }
          
          Text("추천 \(feed.likeCount)")
            .font(.system(size: 13, weight: .bold))
            .foregroundColor(Color.fwGray)
        }
        .padding(.horizontal, 4)
        
        Spacer()
        
        Button {
          isSaveCafeViewShown = true
        } label: {
          Image(uiImage: feed.isBookmarked ? R.image.bookmark_filled()! : R.image.bookmark()!)
            .resizable()
            .padding(6)
            .frame(width: 32, height: 32)
            .foregroundColor(feed.isBookmarked ? .fwBlack : .fwGray)
        }
      }
      .padding(.horizontal, 4)
      .padding(.top, 16)
    }
    .sheet(isPresented: $isSaveCafeViewShown, content: {
      let viewModel = SaveCafeViewModel()
      SaveCafeView(viewModel: viewModel)
        .presentationDetents([.fraction(0.5)])
    })
  }
}


// MARK: - Preview

struct FeedItem_Previews: PreviewProvider {
  static var previews: some View {
    let feed = Feed(id: 1,
                    name: "어퍼스트로피",
                    location: "경기도 안양시 어쩌구",
                    distance: 1.312412,
                    images: ["https://picsum.photos/1200/800",
                             "https://picsum.photos/1200/800",
                             "https://picsum.photos/1200/800"],
                    likeCount: Array(0...999).randomElement()!,
                    isLiked: Bool.random(),
                    isBookmarked: Bool.random())
    CafeListItem(feed: feed)
  }
}

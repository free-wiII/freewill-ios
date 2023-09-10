//
//  BookmarkView.swift
//  freewill
//
//  Created by 이승기 on 2023/09/10.
//

import SwiftUI

struct BookmarkView: View {
  
  // MARK: - Properties
  
  @State var sampleBookmarks: [Bookmark] = [
    .init(title: "🫥 가보고싶은 카페 모음", createdAt: .init()),
    .init(title: "🌳 조용한 카페 모음", createdAt: .init()),
    .init(title: "😋 디저트가 맛있는 카페 모음", createdAt: .init())
  ]
  
  
  
  // MARK: - Views
  
  var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        NavigationBar(leadingContent: {
          Text("북마크")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.fwBlack)
        })
        
        ScrollView {
          VStack(spacing: 0) {
            ForEach(sampleBookmarks, id: \.id) { bookmark in
                NavigationLink {
                  Text(bookmark.title)
                } label: {
                  VStack(spacing: 0) {
                    bookmarkItem(bookmark)
                    
                    Divider()
                      .overlay(Color.fwGray20)
                  }
                }
            }
          }
          .padding(.horizontal, 20)
          .padding(.vertical, 24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
    }
  }
  
  private func bookmarkItem(_ bookmark: Bookmark) -> some View {
    VStack {
      Text(bookmark.title)
        .font(.system(size: 15, weight: .medium))
        .foregroundColor(.fwBlack)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .frame(height: 56)
  }
}

struct BookmarkView_Previews: PreviewProvider {
  static var previews: some View {
    BookmarkView()
  }
}

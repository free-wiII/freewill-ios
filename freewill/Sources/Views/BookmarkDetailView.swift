//
//  BookmarkDetailView.swift
//  freewill
//
//  Created by 이승기 on 2023/09/10.
//

import SwiftUI

struct BookmarkDetailView: View {
  
  // MARK: - Properties
  
  @Environment(\.dismiss) private var dismiss
  @State var sampleBookmarks: [Bookmark] = [
    .init(title: "어퍼스트로피", location: "경기도 안양시 어쩌구", images: [.init(), .init(), .init()]),
    .init(title: "title", location: "location", images: [.init()]),
    .init(title: "title", location: "location", images: [.init(), .init()])
  ]
  
  
  // MARK: - Views
  
  var body: some View {
    VStack(spacing: 0) {
      NavigationBar {
        Button {
          dismiss()
        } label: {
          Image(uiImage: R.image.chevron_left()!)
            .resizable()
            .padding(6)
            .frame(width: 32, height: 32)
            .foregroundColor(.fwBlack)
        }
      } centerContent: {
        Text("title")
          .font(.system(size: 17, weight: .bold))
          .foregroundColor(.fwBlack)
      }
      
      ScrollView {
        LazyVStack(spacing: 24) {
          ForEach(sampleBookmarks, id: \.id) { bookmark in
            bookmarkItem(bookmark)
          }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 24)
      }
    }
  }
  
  private func bookmarkItem(_ bookmark: Bookmark) -> some View {
    VStack(spacing: 20) {
      VStack(spacing: 2) {
        Text(bookmark.title)
          .font(.system(size: 15, weight: .bold))
          .foregroundColor(.fwBlack)
          .frame(maxWidth: .infinity, alignment: .leading)
        
        Text(bookmark.location)
          .font(.system(size: 13))
          .foregroundColor(.fwBlack)
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      .padding(.horizontal, 4)
      
      HStack(spacing: 4) {
        ForEach(bookmark.images, id: \.self) { image in
          RoundedRectangle(cornerRadius: 12)
            .fill(Color.fwGray20)
            .aspectRatio(bookmark.images.count == 3 ? 1/1
                         : (bookmark.images.count == 2 ? 4/3 : 2/1),
                         contentMode: .fill)
        }
      }
    }
  }
}


// MARK: - Properties

struct BookmarkDetailView_Previews: PreviewProvider {
  static var previews: some View {
    BookmarkDetailView()
  }
}

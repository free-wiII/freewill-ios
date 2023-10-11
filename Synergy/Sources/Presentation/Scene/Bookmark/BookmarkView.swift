//
//  BookmarkView.swift
//  Synergy
//
//  Created by 이승기 on 2023/09/10.
//

import SwiftUI

struct BookmarkView: View {
  
  // MARK: - Properties
  
  @EnvironmentObject private var tabBarConfig: TabBarConfig
  @State private var didAppear = false
  
  @StateObject var viewModel: BookmarkViewModel
  
  
  // MARK: - Views
  
  var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        NavigationBar(leadingContent: {
          Text("북마크")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.fwBlack)
        })
        
        if viewModel.isLoading {
          Spacer()
          ProgressView()
          Spacer()
        } else {
          ScrollView {
            VStack(spacing: 0) {
              ForEach(viewModel.bookmarkGroups, id: \.id) { bookmark in
                  NavigationLink {
                    BookmarkDetailView(viewModel: .init())
                  } label: {
                    VStack(spacing: 0) {
                      bookmarkGroupItem(bookmark)
                      
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
    .navigationViewStyle(.stack)
    .onAppear {
      if didAppear == false {
        viewModel.fetchBookmarkGroup()
        didAppear = true
      }
    }
  }
  
  private func bookmarkGroupItem(_ bookmarkGroup: BookmarkGroup) -> some View {
    VStack {
      Text(bookmarkGroup.title)
        .font(.system(size: 15, weight: .medium))
        .foregroundColor(.fwBlack)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .frame(height: 56)
  }
}

struct BookmarkView_Previews: PreviewProvider {
  static var previews: some View {
    BookmarkView(viewModel: .init())
  }
}

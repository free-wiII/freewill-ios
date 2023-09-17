//
//  SaveCafeView.swift
//  freewill
//
//  Created by 이승기 on 2023/09/17.
//

import SwiftUI

struct SaveCafeView: View {
  
  // MARK: - Properties
  
  @State private var didAppear = false
  @StateObject var viewModel: SaveCafeViewModel
  
  
  // MARK: - Views
  
  var body: some View {
    VStack(spacing: 0) {
      navigationBar()
      
      if viewModel.isLoading {
        Spacer()
        ProgressView()
        Spacer()
      } else {
        ScrollView {
          LazyVStack(spacing: 0) {
            makeNewGroupView()
            ForEach(viewModel.bookmarkGroups, id: \.id) { bookmarkGroup in
              bookmarkGroupItem(bookmarkGroup)
              
              Divider()
                .overlay(Color.fwGray20)
            }
          }
          .padding(.horizontal, 20)
        }
      }
      
      BottomContainerButton("저장", enabled: .constant(true)) {
        // action
      }
    }
    .onAppear {
      if didAppear == false {
        viewModel.fetchBookmarkGroups()
        didAppear = true
      }
    }
  }
  
  private func navigationBar() -> some View {
    ZStack {
      Text("title")
        .font(.system(size: 20, weight: .bold))
        .foregroundStyle(Color.fwBlack)
      
      HStack {
        Spacer()
        
        Button {
          // action
        } label: {
          Image(uiImage: R.image.x()!)
            .resizable()
            .padding(8)
            .frame(width: 32, height: 32)
            .foregroundStyle(Color.fwBlack)
        }
      }
      .padding(.horizontal, 16)
      .frame(height: 64)
    }
  }
  
  private func makeNewGroupView() -> some View {
    Button {
      // action
    } label: {
      HStack(spacing: 12) {
        Image(uiImage: R.image.folder_plus()!)
          .resizable()
          .frame(width: 20, height: 20)
        
        Text("새 그룹 만들기")
          .font(.system(size: 15, weight: .medium))
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      .foregroundStyle(Color.fwGray70)
      .frame(height: 56)
    }
  }
  
  private func bookmarkGroupItem(_ bookmarkGroup: BookmarkGroup) -> some View {
    HStack(spacing: 20) {
      Text(bookmarkGroup.title)
        .font(.system(size: 15, weight: .medium))
        .frame(maxWidth: .infinity ,alignment: .leading)
        .foregroundStyle(Color.fwBlack)
      
      Button {
        // action
        viewModel.selectedGroup = bookmarkGroup
      } label: {
        if let selectedGroup = viewModel.selectedGroup,
           selectedGroup == bookmarkGroup {
          RoundedRectangle(cornerRadius: 6)
            .fill(Color.fwBlack)
            .overlay {
              Image(uiImage: R.image.check()!)
                .resizable()
                .frame(width: 12, height: 12)
                .foregroundStyle(Color.fwWhite)
            }
            .frame(width: 24, height: 24)
        } else {
          RoundedRectangle(cornerRadius: 6)
            .fill(Color.fwGray20)
            .overlay {
              RoundedRectangle(cornerRadius: 6)
                .stroke(Color.fwBlack, lineWidth: 1)
            }
            .frame(width: 24, height: 24)
        }
      }
    }
    .frame(height: 56)
  }
}


// MARK: - Preview

#Preview {
  SaveCafeView(viewModel: .init())
}

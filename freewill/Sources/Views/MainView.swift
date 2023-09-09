//
//  MainView.swift
//  freewill
//
//  Created by 이승기 on 2023/09/07.
//

import SwiftUI

struct MainView: View {
  
  // MARK: - Properties
  
  @StateObject var viewModel = MainViewModel()
  
  
  // MARK: - Views
  
  var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        NavigationBar(leadingContent: {
          Text("자유의지")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(Color.fwBlack)
        }, trailingContent: {
          HStack(spacing: 8) {
            NavigationLink {
              SearchView(viewModel: .init())
                .toolbar(.hidden, for: .navigationBar)
            } label: {
              Image(uiImage: R.image.loupe()!)
                .resizable()
                .padding(6)
                .frame(width: 32, height: 32)
                .foregroundColor(Color.fwBlack)
            }
            
            Button {
              // action
            } label: {
              Image(uiImage: R.image.plus()!)
                .resizable()
                .padding(6)
                .frame(width: 32, height: 32)
                .foregroundColor(Color.fwBlack)
            }
          }
        }, isDividerShown: false)
        
        FilterCriteriaSelector(selectedCriteria: $viewModel.selectedCriteria)
        
        ScrollView {
          LazyVStack(spacing: 24) {
            ForEach(0..<10) { _ in
              FeedItem()
            }
          }
          .padding(.vertical, 20)
          .padding(.horizontal, 16)
        }
      }
    }
  }
}


// MARK: - Preview

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MainView()
  }
}

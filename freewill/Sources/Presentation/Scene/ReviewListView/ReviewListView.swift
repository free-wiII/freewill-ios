//
//  ReviewListView.swift
//  freewill
//
//  Created by 이승기 on 2023/09/22.
//

import SwiftUI

struct ReviewListView: View {
  
  // MARK: - Properties
  
  @Environment(\.dismiss) private var dismiss
  
  @StateObject var viewModel: ReviewListViewModel
  
  
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
        Text("방명록")
          .font(.system(size: 17, weight: .bold))
          .foregroundStyle(Color.fwBlack)
      })
      
      if viewModel.isLoading {
        VStack {
          ProgressView()
        }
        .frame(maxHeight: .infinity)
      } else {
        ScrollView {
          LazyVStack(spacing: 20) {
            ForEach(viewModel.reviews, id: \.userId) { review in
              ReviewListItem(review: review)
            }
          }
          .padding(.horizontal, 16)
          .padding(.vertical, 24)
        }
      }
    }
    .toolbar(.hidden, for: .navigationBar)
    .onAppear {
      viewModel.fetchReviewList()
    }
  }
}

#Preview {
  ReviewListView(viewModel: .init())
}

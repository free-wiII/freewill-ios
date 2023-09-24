//
//  CafeDetailView.swift
//  freewill
//
//  Created by 이승기 on 2023/09/18.
//

import SwiftUI
import MapKit

struct CafeDetailView: View {
  
  // MARK: - Properties
  
  @Environment(\.dismiss) private var dismiss
  @State private var didAppear = false
  
  @StateObject var viewModel: CafeDetailViewModel
  
  @State private var selectedImageIndex = 0
  private let column = [
    GridItem(.flexible(minimum: 120, maximum: .infinity), spacing: 28, alignment: .center),
    GridItem(.flexible(minimum: 120, maximum: .infinity), spacing: 28, alignment: .center)
  ]
  
  
  // MARK: - Views
  
  var body: some View {
    ZStack(alignment: .bottom) {
      if viewModel.isLoading {
        VStack {
          ProgressView()
        }
        .frame(maxHeight: .infinity)
      } else {
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
            Text(viewModel.name)
              .font(.system(size: 17, weight: .bold))
              .foregroundStyle(Color.fwBlack)
          })
          
          ScrollView {
            VStack(spacing: 28) {
              imagePagingView()
              ratingSection()
              locationSection()
              reviewSection()
              
              Spacer()
                .frame(height: 100)
            }
            .padding(.vertical, 20)
            .padding(.horizontal, 16)
          }
        }
        
        reviewPopUp()
          .padding(12)
      }
    }
    .toolbar(.hidden, for: .navigationBar)
    .onAppear {
      if didAppear == false {
        viewModel.fetchCafeDetail()
        didAppear = true
      }
    }
  }
  
  private func imagePagingView() -> some View {
    VStack(spacing: 16) {
      ZStack(alignment: .init(horizontal: .trailing, vertical: .bottom), content: {
        RoundedRectangle(cornerRadius: 12)
          .fill(Color.fwGray30)
          .aspectRatio(1/1, contentMode: .fill)
          .overlay {
            TabView(selection: $selectedImageIndex) {
              ForEach(Array(viewModel.images.enumerated()), id: \.offset) { index, imageUrl in
                AsyncImage(url: URL(string: imageUrl)) { image in
                  image.resizable()
                    .aspectRatio(1/1, contentMode: .fill)
                } placeholder: {
                  ProgressView()
                }
              }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .clipShape(RoundedRectangle(cornerRadius: 12))
          }
        
        Text("\(selectedImageIndex + 1) / \(viewModel.images.count)")
          .font(.system(size: 13, weight: .bold))
          .foregroundStyle(Color.fwBlack)
          .padding(.horizontal, 10)
          .padding(.vertical, 6)
          .background {
            BlurView()
              .clipShape(RoundedRectangle(cornerRadius: 8))
          }
          .padding(12)
      })
      
      HStack {
        HStack(spacing: 8) {
          Button {
            viewModel.isLiked.toggle()
          } label: {
            Image(uiImage: viewModel.isLiked ? R.image.thumbsup_filled()! : R.image.thumbsup()!)
              .resizable()
              .frame(width: 24, height: 24)
              .foregroundStyle(viewModel.isLiked ? Color.fwPink : Color.fwGray)
          }
          
          Text("추천 \(viewModel.likeCount)")
            .font(.system(size: 13, weight: .bold))
            .foregroundStyle(Color.fwGray)
        }
        
        Spacer()
        
        Button {
          viewModel.isBookmarked.toggle()
        } label: {
          Image(uiImage: viewModel.isBookmarked ? R.image.bookmark_filled()! : R.image.bookmark()!)
            .resizable()
            .padding(6)
            .frame(width: 32, height: 32)
            .foregroundStyle(viewModel.isBookmarked ? Color.fwBlack : Color.fwGray)
        }
      }
      .padding(.horizontal, 4)
      .frame(height: 32)
      .padding(.horizontal, 4)
    }
  }
  
  private func ratingSection() -> some View {
    VStack(spacing: 0) {
      Text("평균평점 4.3")
        .font(.system(size: 17, weight: .semibold))
        .foregroundStyle(Color.fwBlack)
        .frame(maxWidth: .infinity, maxHeight: 52, alignment: .leading)
      
      LazyVGrid(columns: column, spacing: 20, content: {
        ForEach(viewModel.ratings, id: \.criteria) { rating in
          VStack(spacing: 5) {
            HStack {
              Text("\(rating.criteria.emoji) \(rating.criteria.description)")
                .font(.system(size: 13))
                .foregroundStyle(Color.fwBlack)
                .frame(maxWidth: .infinity, alignment: .leading)
              
              Text(rating.score.description)
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(Color.fwBlack)
            }
        
            RatingProgressBar(value: rating.score)
          }
        }
      })
      .padding(.vertical, 12)
    }
  }
  
  private func locationSection() -> some View {
    VStack(spacing: 0) {
      HStack {
        Text("카페 위치")
          .font(.system(size: 17, weight: .semibold))
        
        Spacer()
        
        Text("\(viewModel.location.distance.asTwoDecimalString)km")
          .font(.system(size: 14, weight: .medium))
      }
      .foregroundStyle(Color.fwBlack)
      .frame(height: 52)
      
      VStack(spacing: 0) {
        Map(coordinateRegion: $viewModel.region)
          .frame(height: 116)
          .overlay {
            Image(uiImage: R.image.marker()!)
              .resizable()
              .frame(width: 24, height: 24)
              .foregroundStyle(Color.fwPink)
          }
          .disabled(true)
        
        HStack(spacing: 4) {
          Image(uiImage: R.image.marker()!)
            .resizable()
            .frame(width: 16, height: 16)
            
          Text(viewModel.location.address)
            .font(.system(size: 13))
          
          Spacer()
        }
        .foregroundStyle(Color.fwBlack)
        .padding(.horizontal, 12)
        .frame(height: 40)
      }
      .clipShape(RoundedRectangle(cornerRadius: 8))
      .overlay {
        RoundedRectangle(cornerRadius: 8)
          .stroke(Color.fwGray20, lineWidth: 1)
      }
    }
  }
  
  private func reviewSection() -> some View {
    VStack(spacing: 20) {
      HStack {
        Text("방명록")
          .font(.system(size: 17, weight: .semibold))
          .foregroundStyle(Color.fwBlack)
        
        Spacer()
        
        NavigationLink {
          let viewModel = ReviewListViewModel()
          ReviewListView(viewModel: viewModel)
        } label: {
          Text("방명록 모두 보기")
            .font(.system(size: 13, weight: .medium))
            .foregroundStyle(Color.fwBlack)
            .padding(8)
            .overlay {
              RoundedRectangle(cornerRadius: 8)
                .stroke(Color.fwBlack, lineWidth: 1)
            }
        }
      }
      .frame(height: 52)
      
      VStack(spacing: 18) {
        ForEach(viewModel.featuresReviews, id: \.userId) { review in
          ReviewListItem(review: review)
        }
      }
    }
  }
  
  private func reviewPopUp() -> some View {
    HStack {
      VStack(alignment: .leading, spacing: 0) {
        Text("이 카페에 다녀오셨나요?")
          .font(.system(size: 16, weight: .bold))
        
        Text("방명록을 작성해 보세요!")
          .font(.system(size: 13, weight: .medium))
      }
      .foregroundStyle(Color.fwWhite)
      .padding(.leading, 12)
      
      Spacer()
      
      NavigationLink {
        WriteReviewView()
      } label: {
        Text("작성하기")
          .font(.system(size: 14, weight: .bold))
          .frame(maxWidth: 84, maxHeight: .infinity)
          .foregroundStyle(Color.fwBlack)
          .background(Color.fwWhite)
          .clipShape(Capsule())
      }
    }
    .padding(12)
    .background(Color.fwBlack)
    .frame(height: 60)
    .clipShape(Capsule())
  }
}


// MARK: - Preview

#Preview {
  CafeDetailView(viewModel: .init())
}

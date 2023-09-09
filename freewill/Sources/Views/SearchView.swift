//
//  SearchView.swift
//  freewill
//
//  Created by 이승기 on 2023/09/08.
//

import SwiftUI
import MapKit

struct SearchView: View {
  
  // MARK: - Properties
  
  @Environment(\.dismiss) private var dismiss
  
  @StateObject var viewModel: SearchViewModel
  
  @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5666791, longitude: 126.9782914), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
  
  private let columns = [
    GridItem(.adaptive(minimum: 75), spacing: 8, alignment: .leading)
  ]


  // MARK: - Views
  
  var body: some View {
    VStack(spacing: 0) {
      NavigationBar(leadingContent: {
        Button {
          dismiss()
        } label: {
          Image(uiImage: R.image.chevron_left()!)
            .resizable()
            .padding(6)
            .frame(width: 32, height: 32)
            .foregroundColor(.fwBlack)
        }
      }, centerContent: {
        Text("검색")
          .font(.system(size: 17, weight: .semibold))
          .foregroundColor(.fwBlack)
      })
      
      ScrollView {
        VStack(spacing: 28) {
          mapSelectionSection()
          prioritySelectionSection()
        }
        .padding(.vertical, 12)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .ignoresSafeArea()
      
      BottomContainerButton("검색", enabled: .constant(true)) {
        // action
      }
      .shadow(color: .fwBlack.opacity(0.1), radius: 20, x: 0, y: -4)
    }
  }
  
  private func mapSelectionSection() -> some View {
    VStack(spacing: 0) {
      sectionHeader(title: "지역 선택",
                    subTitle: "지도를 움직여 검색하고 싶은 위치로 이동해보세요.")
      
      Map(coordinateRegion: $region)
        .aspectRatio(335/220, contentMode: .fill)
        .frame(maxWidth: .infinity)
        .cornerRadius(8)
        .overlay {
          RoundedRectangle(cornerRadius: 8)
            .stroke(Color.fwGray20, lineWidth: 1)
        }
    }
    .padding(.horizontal, 16)
  }
  
  private func prioritySelectionSection() -> some View {
    VStack(spacing: 0) {
      sectionHeader(title: "우선순위",
                    subTitle: "찾고싶은 카페의 유형 우선순위를 설정해 보세요.")
      .padding(.horizontal, 16)
      
      GridView(gridWidth: UIScreen.main.bounds.size.width - 32,
               spacing: 8,
               numItems: Rating.allCases.count,
               alignment: .center) { index in
        let rating = Rating(rawValue: index)!
        Button {
          viewModel.addPriority(rating)
        } label: {
          Text("\(rating.emoji) \(rating.shortDescription)")
            .font(.system(size: 13, weight: .semibold))
            .foregroundColor(.fwBlack)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.fwGray20)
            .clipShape(Capsule())
        }
      }
      
      Text("선택됨 (\(viewModel.selectedPriority.count))")
        .font(.system(size: 13))
        .foregroundColor(.fwGray60)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 8) {
          ForEach(Array(viewModel.selectedPriority.enumerated()), id: \.offset) { index, rating in
            selectedPriority(index: index, rating: rating)
          }
        }
        .padding(.horizontal, 16)
      }
      .frame(height: 32)
    }
  }
  
  private func sectionHeader(title: String, subTitle: String) -> some View {
    VStack(spacing: 2) {
      Text(title)
        .font(.system(size: 17, weight: .semibold))
        .foregroundColor(.fwBlack)
        .frame(maxWidth: .infinity, alignment: .leading)
      
      Text(subTitle)
        .font(.system(size: 13))
        .foregroundColor(.fwGray60)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    .frame(height: 52)
  }
  
  private func selectedPriority(index: Int, rating: Rating) -> some View {
    HStack(spacing: 4) {
      Circle()
        .fill(Color.fwWhite)
        .overlay {
          Text((index + 1).description)
            .font(.system(size: 10, weight: .bold))
            .foregroundColor(.fwBlack)
            .background(Color.fwWhite)
        }
        .frame(width: 16, height: 16)

      Text(rating.shortDescription)
        .font(.system(size: 13, weight: .semibold))
        .foregroundColor(.fwWhite)
      
      Button {
        viewModel.removePriority(rating)
      } label: {
        Image(uiImage: R.image.x()!)
          .resizable()
          .padding(2)
          .frame(width: 16, height: 16)
          .foregroundColor(.fwWhite)
      }
    }
    .padding(.horizontal, 12)
    .frame(height: 32)
    .background(Color.fwBlack)
    .clipShape(Capsule())
  }
}

struct SearchView_Previews: PreviewProvider {
  static var previews: some View {
    SearchView(viewModel: .init())
  }
}

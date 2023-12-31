//
//  UploadCafeNameView.swift
//  Synergy
//
//  Created by 이승기 on 2023/10/11.
//

import SwiftUI

struct UploadCafeNameView: View {
  
  // MARK: - Properties
  
  @Environment(\.dismiss) private var dismiss
  @EnvironmentObject private var tabBarConfig: TabBarConfig
  
  @StateObject var viewModel: UploadCafeNameViewModel
  
  
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
        Text("카페 이름")
          .font(.system(size: 17, weight: .bold))
          .foregroundStyle(Color.fwBlack)
      })
      
      UnderlineTextField(placeholder: "카페 이름을 설정해 주세요",
                         text: $viewModel.cafeName,
                         focused: true)
      .padding(.top, 20)
      .padding(.horizontal, 16)
      
      ScrollView {
        // auto complete content
      }
      
      BottomNavigationContainerButton("다음", enabled: .constant(!viewModel.cafeName.isEmpty)) {
        let viewModel = UploadCafeImageViewModel()
        UploadCafeImageView(viewModel: viewModel)
      }
    }
    .toolbar(.hidden, for: .navigationBar)
    .toolbar(.hidden, for: .tabBar)
    .onAppear {
      if isPreview == false {
        tabBarConfig.isTabBarHidden = true
      }
    }
  }
}


// MARK: - Preview

#Preview {
  NavigationView(content: {
    UploadCafeNameView(viewModel: .init())
  })
}

//
//  MakeBookmarkGroupView.swift
//  freewill
//
//  Created by 이승기 on 2023/09/17.
//

import SwiftUI

struct MakeBookmarkGroupView: View {
  
  // MARK: - Properties
  
  @Environment(\.dismiss) private var dismiss
  
  @StateObject var viewModel: MakeBookmarkGroupViewModel
  
  
  // MARK: - Views
  
  var body: some View {
    VStack(spacing: 0) {
      navigationBar()
      
      Spacer()
      
      UnderlineTextField(placeholder: "그룹 이름",
                         text: $viewModel.groupName,
                         focused: true)
      .padding(.horizontal, 16)
      .tint(Color.fwBlack)
      
      Spacer()
      
      BottomContainerButton("완료", enabled: .constant(!viewModel.groupName.isEmpty)) {
        // action
      }
    }
  }
  
  private func navigationBar() -> some View {
    ZStack {
      Text("새 그룹 만들기")
        .font(.system(size: 20, weight: .bold))
        .foregroundStyle(Color.fwBlack)
      
      HStack {
        Spacer()
        
        Button {
          dismiss()
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
}


// MARK: - Preview

#Preview {
  MakeBookmarkGroupView(viewModel: .init())
}

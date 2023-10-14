//
//  UploadCafeImageView.swift
//  Synergy
//
//  Created by 이승기 on 2023/10/12.
//

import SwiftUI
import PhotosUI

struct UploadCafeImageView: View {
  
  // MARK: - Properties
  
  @Environment(\.dismiss) private var dismiss
  
  @StateObject var viewModel: UploadCafeImageViewModel

  @State private var selectedImageIndex = 0
  @State private var removeImageTargetIndex = 0
  
  @State private var isPhotoLimitAlertShown = false
  @State private var isRemoveImageDialogShown = false
  
  
  // MARK: - Views
  
  var body: some View {
    VStack(spacing: 0) {
      NavigationBar {
        Button {
          dismiss()
        } label: {
          Image(uiImage: R.image.chevron_left()!)
            .resizable()
            .padding(8)
            .frame(width: 32, height: 32)
            .foregroundStyle(Color.fwBlack)
        }
      } centerContent: {
        Text("이미지 등록")
          .font(.system(size: 17, weight: .bold))
          .foregroundStyle(Color.fwBlack)
      }
      
      ScrollView {
        VStack(spacing: 20) {
          imagePreview()
            .padding(.horizontal, 16)
          
          imageSelectorView()
        }
        .padding(.vertical, 20)
      }
      
      BottomContainerButton("다음", enabled: .constant(!viewModel.selectedImages.isEmpty)) {
        // action
      }
    }
    .toolbar(.hidden, for: .navigationBar)
  }
  
  private func imagePreview() -> some View {
    ZStack(alignment: .init(horizontal: .trailing, vertical: .bottom), content: {
      RoundedRectangle(cornerRadius: 12)
        .fill(Color.fwGray30)
        .aspectRatio(1/1, contentMode: .fill)
        .overlay {
          TabView(selection: $selectedImageIndex) {
            ForEach(Array(viewModel.selectedImages.enumerated()), id: \.offset) { index, image in
              Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .aspectRatio(1/1, contentMode: .fill)
            }
          }
          .tabViewStyle(.page(indexDisplayMode: .never))
          .clipShape(RoundedRectangle(cornerRadius: 12))
        }
      
      if viewModel.selectedImages.isEmpty {
        Text("최소 한 장의 이미지를 등록해 주세요.\n최대 10장까지 첨부 가능해요!")
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .font(.system(size: 17, weight: .medium))
          .foregroundStyle(Color.fwGray60)
          .multilineTextAlignment(.center)
      } else {
        Text("\(selectedImageIndex + 1) / \(viewModel.selectedImages.count)")
          .font(.system(size: 13, weight: .bold))
          .foregroundStyle(Color.fwBlack)
          .padding(.horizontal, 10)
          .padding(.vertical, 6)
          .background {
            BlurView()
              .clipShape(RoundedRectangle(cornerRadius: 8))
          }
          .padding(12)
      }
    })
    .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 4)
  }
  
  private func imageSelectorView() -> some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 8) {
        PhotosPicker(selection: $viewModel.selectedItems, matching: .images) {
          Image(uiImage: R.image.plus()!)
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundStyle(Color.fwGray)
            .frame(width: 88, height: 88)
            .background {
              RoundedRectangle(cornerRadius: 12)
                .stroke(Color.fwGray60, lineWidth: 1)
                .padding(1)
            }
        }
        
        ForEach(Array(viewModel.selectedImages.enumerated()), id: \.offset) { index, image in
          Button {
            removeImageTargetIndex = index
            isRemoveImageDialogShown = true
          } label: {
            Image(uiImage: image)
              .resizable()
              .scaledToFill()
              .aspectRatio(1/1, contentMode: .fill)
              .frame(width: 88, height: 88)
              .clipShape(
                RoundedRectangle(cornerRadius: 12)
              )
          }
        }
      }
      .padding(.horizontal, 16)
      .confirmationDialog("선택된 사진 삭제", isPresented: $isRemoveImageDialogShown) {
        Button("삭제", role: .destructive) { 
          viewModel.removeImage(index: removeImageTargetIndex)
        }
      } message: {
        Text("선택된 사진을 삭제하시겠나요?")
      }
    }
    .frame(maxWidth: .infinity)
    .onChange(of: viewModel.selectedItems) { newValue in
      Task {
        // 최대 업로드 가능 이미지 갯수 10장
        if newValue.count > 10 {
          isPhotoLimitAlertShown = true
        }
        
        viewModel.selectedImages.removeAll()
        
        
        for (index, item) in newValue.enumerated() {
          if index == 10 { break }
          
          if let data = try? await item.loadTransferable(type: Data.self) {
            if let image = UIImage(data: data) {
              viewModel.selectedImages.append(image)
            }
          }
        }
      }
    }
    .alert(isPresented: $isPhotoLimitAlertShown) {
      Alert(title: Text("최대 이미지 갯수 제한"),
            message: Text("최대로 업로드할 수 있는 이미지 갯수는 10장 입니다."),
            dismissButton: .default(Text("확인")))
    }
  }
}

#Preview {
  UploadCafeImageView(viewModel: .init())
}

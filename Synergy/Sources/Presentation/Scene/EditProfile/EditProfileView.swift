//
//  EditProfileView.swift
//  Synergy
//
//  Created by 이승기 on 2023/09/10.
//

import SwiftUI

struct EditProfileView: View {
  
  // MARK: - Properties
  
  @Environment(\.dismiss) private var dismiss
  
  
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
        Text("프로필 편집")
          .font(.system(size: 17, weight: .bold))
          .foregroundColor(.fwBlack)
      }

      VStack(spacing: 10) {
        Circle()
          .fill(Color.fwGray20)
          .frame(width: 112, height: 112)
          .padding(.top, 24)
        
        Button {
          
        } label: {
          HStack(spacing: 5) {
            Image(uiImage: R.image.camera()!)
              .resizable()
              .frame(width: 12, height: 12)
              .foregroundColor(.fwBlack)
            
            Text("변경")
              .font(.system(size: 13, weight: .medium))
              .foregroundColor(.fwBlack)
          }
          .padding(.horizontal, 12)
          .padding(.vertical, 6)
          .background(
            Capsule()
              .stroke(Color.fwGray40, lineWidth: 1)
          )
        }
      }
      
      UnderlineTextField(placeholder: "새로운 닉네임", text: .constant("홍길동"), focused: false)
        .padding(.horizontal, 24)
        .padding(.top, 48)
      
      Spacer()
      
      UnderlinedButton("회원탈퇴") {
        // withdraw action
      }
      .padding(.bottom, 20)
      
      BottomContainerButton("적용", enabled: .constant(true)) {
        dismiss()
      }
    }
  }
}

struct EditProfileView_Previews: PreviewProvider {
  static var previews: some View {
    EditProfileView()
  }
}

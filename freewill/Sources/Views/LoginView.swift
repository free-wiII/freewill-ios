//
//  LoginView.swift
//  freewill
//
//  Created by 이승기 on 2023/09/07.
//

import SwiftUI

struct LoginView: View {
  
  // MARK: - Properties
  
  @Environment(\.dismiss) private var dismiss
  
  
  // MARK: - Views
  
  var body: some View {
    VStack {
      Text("환영합니다.\n멘트 어쩌구")
        .font(.system(size: 32, weight: .heavy))
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 48)
        .padding(.leading, 24)
      
      Spacer()
      

      VStack(spacing: 14) {
        kakaoLoginButton()
        googleLoginButton()
        appleLoginButton()
      }
      .padding(.horizontal, 16)
      
      Spacer()
        .frame(height: 36)

      UnderlinedButton("로그인 없이 둘러보기") {
        dismiss()
      }
  
      Spacer()
        .frame(height: 20)
    }
  }
  
  
  private func kakaoLoginButton() -> some View {
    Button {
      // action
    } label: {
      ZStack {
        Capsule()
          .stroke(Color.fwBlack, lineWidth: 1)
        
        Text(LoginType.kakao.description)
          .font(.system(size: 15, weight: .semibold))
          .foregroundColor(Color.fwBlack)
        
        HStack(spacing: 0) {
          Image(uiImage: LoginType.kakao.image)
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(Color.fwBlack)
          
          Spacer()
        }
        .padding(.horizontal, 20)
      }
      .frame(maxHeight: 48)
    }
  }
  
  private func googleLoginButton() -> some View {
    Button {
      // action
    } label: {
      ZStack {
        Capsule()
          .stroke(Color.fwBlack, lineWidth: 1)
        
        Text(LoginType.google.description)
          .font(.system(size: 15, weight: .semibold))
          .foregroundColor(.fwBlack)
        
        HStack(spacing: 0) {
          Image(uiImage: LoginType.google.image)
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(Color.fwBlack)
          
          Spacer()
        }
        .padding(.horizontal, 20)
      }
      .frame(maxHeight: 48)
    }
  }
  
  private func appleLoginButton() -> some View {
    Button {
      // action
    } label: {
      ZStack {
        Text(LoginType.apple.description)
          .font(.system(size: 15, weight: .semibold))
          .foregroundColor(.white)
        
        HStack(spacing: 0) {
          Image(uiImage: LoginType.apple.image)
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(.white)
          
          Spacer()
        }
        .padding(.horizontal, 20)
      }
      .frame(maxHeight: 48)
      .background(Color.fwBlack)
      .clipShape(Capsule())
    }
  }
}

struct LoginView_Previews: PreviewProvider {
  static var previews: some View {
    LoginView()
  }
}

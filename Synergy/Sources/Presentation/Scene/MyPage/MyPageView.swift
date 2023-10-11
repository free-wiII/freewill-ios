//
//  MyPageView.swift
//  freewill
//
//  Created by 이승기 on 2023/09/10.
//

import SwiftUI

struct MyPageView: View {
  
  // MARK: - Properties
  
  @EnvironmentObject private var tabBarConfig: TabBarConfig
  
  
  // MARK: - Views
  
  var body: some View {
    NavigationView {
      VStack {
        NavigationBar {
          Text("마이 페이지")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.fwBlack)
        } trailingContent: {
          NavigationLink {
            EditProfileView()
              .toolbar(.hidden, for: .navigationBar)
              .toolbar(.hidden, for: .tabBar)
              .onDisappear {
                if isPreview == false {
                  tabBarConfig.isTabBarHidden = false
                }
              }
          } label: {
            Image(uiImage: R.image.edit()!)
              .resizable()
              .padding(6)
              .frame(width: 32, height: 32)
              .foregroundColor(.fwBlack)
          }
        }
        
        VStack(spacing: 0) {
          infoSection()
          
          Spacer()
          
          logoutButton()
        }
        .padding(.vertical, 20)
      }
    }
    .navigationViewStyle(.stack)
  }
  
  private func infoSection() -> some View {
    HStack {
      Circle()
        .fill(Color.fwGray20)
        .frame(width: 92, height: 92)
      
      Spacer()
      
      VStack(alignment: .trailing, spacing: 8) {
        Text("편의점 떡볶이")
          .font(.system(size: 22, weight: .bold))
          .foregroundColor(.fwBlack)
        
        Text("avocado34.131@gmail.com")
          .font(.system(size: 15))
          .foregroundColor(.fwGray60)
          .tint(Color.fwGray60) // url color tinting 들어가는 거 방지
      }
    }
    .padding(.horizontal, 24)
  }
  
  private func logoutButton() -> some View {
    UnderlinedButton("로그아웃") {
      // logout action
    }
  }
}

struct MyPageView_Previews: PreviewProvider {
  static var previews: some View {
    MyPageView()
  }
}

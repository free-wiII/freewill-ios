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
  @StateObject var viewModel: MyPageViewModel
  
  private let sessionManager = LoginSessionManager()
  
  @State private var isLoggedIn = false
  @State private var isLoginViewShown = false
  
  
  // MARK: - Views
  
  var body: some View {
    NavigationView {
      VStack(spacing: 0) {
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
          .opacity(isLoggedIn ? 1.0 : 0)
        }
        
        if isLoggedIn {
          loggedInView()
        } else {
          loggedOutView()
        }
      }
    }
    .navigationViewStyle(.stack)
    .onAppear {
      checkLoginState()
    }
    .sheet(isPresented: $isLoginViewShown) {
      let viewModel = LoginViewModel()
      LoginView(viewModel: viewModel)
        .onDisappear {
          checkLoginState()
        }
    }
  }
  
  private func checkLoginState() {
    if sessionManager.isLoggedIn() {
      viewModel.fetchProfile()
      isLoggedIn = true
    } else {
      isLoggedIn = false
    }
  }
  
  private func loggedOutView() -> some View {
    VStack(spacing: 28) {
      Text("로그인 및 회원가입을 하여 더 많은\n기능을 사용해 보세요!")
        .font(.system(size: 15, weight: .medium))
        .foregroundStyle(Color.fwGray70)
        .multilineTextAlignment(.center)
      
      Button {
        isLoginViewShown = true
      } label: {
        RoundedRectangle(cornerRadius: 12)
          .fill(Color.fwBlack)
          .overlay {
            Text("로그인/회원가입")
              .font(.system(size: 15, weight: .bold))
              .foregroundStyle(Color.fwWhite)
          }
          .frame(width: 140, height: 52)
      }
    }
    .frame(maxHeight: .infinity)
  }
  
  @ViewBuilder
  private func loggedInView() -> some View {
    if viewModel.isLoading {
      VStack {
        ProgressView()
      }
      .frame(maxHeight: .infinity)
    } else {
      if let profile = viewModel.profile {
        VStack(spacing: 0) {
          infoSection(profile: profile)
          
          Spacer()
          
          UnderlinedButton("로그아웃") {
            isLoggedIn = false
          }
        }
        .padding(.vertical, 20)
      }
    }
  }
  
  private func infoSection(profile: Profile) -> some View {
    HStack {
      Circle()
        .fill(Color.fwGray20)
        .frame(width: 92, height: 92)
      
      Spacer()
      
      VStack(alignment: .trailing, spacing: 8) {
        Text(profile.nickname)
          .font(.system(size: 22, weight: .bold))
          .foregroundColor(.fwBlack)
        
        Text(profile.email)
          .font(.system(size: 15))
          .foregroundColor(.fwGray60)
          .tint(Color.fwGray60) // url color tinting 들어가는 거 방지
      }
    }
    .padding(.horizontal, 24)
  }
}

struct MyPageView_Previews: PreviewProvider {
  static var previews: some View {
    MyPageView(viewModel: .init())
  }
}

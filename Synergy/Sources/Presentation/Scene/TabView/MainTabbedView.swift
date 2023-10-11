//
//  MainTabbedView.swift
//  Synergy
//
//  Created by 이승기 on 2023/09/06.
//

import SwiftUI

struct MainTabbedView: View {
  
  // MARK: - Properties
  
  @StateObject private var tabBarConfig = TabBarConfig()
  
  @State private var selectedTab: TabItem = .main
  @State private var isLoginViewShown = false
  
  
  // MARK: - Views
  
  var body: some View {
    ZStack(alignment: .bottom) {
      TabView(selection: $selectedTab) {
        FeedView()
          .tag(TabItem.main)
          .toolbar(.hidden, for: .tabBar)
        
        BookmarkView(viewModel: .init())
          .tag(TabItem.bookmark)
          .toolbar(.hidden, for: .tabBar)
        
        MyPageView()
          .tag(TabItem.myPage)
          .toolbar(.hidden, for: .tabBar)
      }
      .ignoresSafeArea()
      
      TabBar(selectedTab: $selectedTab)
        .offset(y: tabBarConfig.isTabBarHidden ? 100 : 0)
        .animation(.spring(), value: tabBarConfig.isTabBarHidden)
    }
    .ignoresSafeArea(.keyboard, edges: .bottom)
    .fullScreenCover(isPresented: $isLoginViewShown) {
      LoginView()
    }
    .onAppear {
      isLoginViewShown = true
    }
    .environmentObject(tabBarConfig)
  }
}


// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MainTabbedView()
  }
}

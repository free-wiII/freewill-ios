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
        
        BookmarkView(viewModel: .init())
          .tag(TabItem.bookmark)
        
        MyPageView()
          .tag(TabItem.myPage)
      }
      
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

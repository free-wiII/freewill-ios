//
//  MainTabbedView.swift
//  freewill
//
//  Created by 이승기 on 2023/09/06.
//

import SwiftUI

struct MainTabbedView: View {
  
  // MARK: - Properties
  
  @State private var selectedTab: TabItem = .main
  
  
  // MARK: - Views
  
  var body: some View {
    ZStack(alignment: .bottom) {
      TabView(selection: $selectedTab) {
        MainView()
          .tag(TabItem.main)
        
        Text("bookmark")
          .tag(TabItem.bookmark)
        
        Text("myPage")
          .tag(TabItem.myPage)
      }
      
      TabBar(selectedTab: $selectedTab)
    }
  }
}


// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    MainTabbedView()
  }
}

//
//  TabBar.swift
//  Synergy
//
//  Created by 이승기 on 2023/09/06.
//

import SwiftUI

struct TabBar: View {
  
  // MARK: - Properties
  
  @Binding var selectedTab: TabItem
  
  
  // MARK: - View
  
  var body: some View {
    VStack(spacing: 0) {
      Divider()
        .overlay {
          Color.fwGray30
        }
      
      HStack {
        ForEach(0..<3) { _ in
          Spacer()
        }
        
        ForEach(TabItem.allCases, id: \.self) { tabItem in
          HStack(spacing: 0) {
            Spacer()
            
            Button {
              selectedTab = tabItem
            } label: {
              VStack(spacing: 4) {
                Image(uiImage: tabItem.image)
                  .resizable()
                  .frame(width: 22, height: 22)
                  .padding(.top, 10)
                
                Text(tabItem.name)
                  .frame(maxWidth: .infinity, alignment: .center)
                  .font(.system(size: 12, weight: .semibold))
              }
              .foregroundColor(tabItem == selectedTab ?  Color.fwBlack : Color.fwGray60)
              .frame(width: 56, height: 56)
            }
            
            Spacer()
          }
        }
        
        ForEach(0..<3) { _ in
          Spacer()
        }
      }
    }
    .background(Color.fwWhite.ignoresSafeArea())
  }
}


// MARK: - Preview

struct TabBar_Preview: PreviewProvider {
  
  struct Container: View {
    @State var selectedTab: TabItem = .main
    
    var body: some View {
      VStack {
        Spacer()
        
        TabBar(selectedTab: $selectedTab)
      }
    }
  }
  
  static var previews: some View {
    Container()
  }
}

//
//  NavigationBar.swift
//  freewill
//
//  Created by 이승기 on 2023/09/07.
//

import SwiftUI

struct NavigationBar<LeadingContent, CenterContent, TrailingContent>: View where LeadingContent: View, CenterContent: View, TrailingContent: View {
  
  // MARK: - Properties
  
  let leadingContent: () -> LeadingContent?
  let centerContent: () -> CenterContent?
  let trailingContent: () -> TrailingContent?
  
  
  // MARK: - Initializers
  
  init(@ViewBuilder leadingContent: @escaping () -> LeadingContent? = { nil },
       @ViewBuilder centerContent: @escaping () -> CenterContent? = { nil },
       @ViewBuilder trailingContent: @escaping () -> TrailingContent? = { nil }) {
    self.leadingContent = leadingContent
    self.centerContent = centerContent
    self.trailingContent = trailingContent
  }
  
  
  // MARK: - Views
  
  var body: some View {
    ZStack {
      HStack(spacing: 8) {
        leadingContent()
        Spacer()
        trailingContent()
      }
      .padding(.horizontal, 12)
      
      centerContent()
      
      VStack {
        Spacer()
        Divider()
          .overlay(Color.fwGray30)
      }
    }
    .background(Color.white.ignoresSafeArea())
    .frame(maxHeight: 52)
  }
}


// MARK: - Preview

struct NavigationBar_Preview: PreviewProvider {
  static var previews: some View {
    VStack() {
      NavigationBar {
        Text("LargeTitle")
          .font(.system(size: 24, weight: .bold))
      } centerContent: {
        Text("title")
          .font(.system(size: 15, weight: .bold))
      } trailingContent: {
        Button {
          // action
        } label: {
          Image(systemName: "gear")
            .resizable()
            .padding(6)
            .frame(width: 32, height: 32)
            
        }
      }
      
      Spacer()
    }
    .background(Color.fwGray20)
  }
}

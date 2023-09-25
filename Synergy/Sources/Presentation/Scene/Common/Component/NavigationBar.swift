//
//  NavigationBar.swift
//  Synergy
//
//  Created by 이승기 on 2023/09/07.
//

import SwiftUI

struct NavigationBar<LeadingContent, CenterContent, TrailingContent>: View where LeadingContent: View, CenterContent: View, TrailingContent: View {
  
  // MARK: - Properties
  
  private let leadingContent: () -> LeadingContent?
  private let centerContent: () -> CenterContent?
  private let trailingContent: () -> TrailingContent?
  private let isDividerShown: Bool
  
  
  
  // MARK: - Initializers
  
  init(@ViewBuilder leadingContent: @escaping () -> LeadingContent? = { EmptyView() },
       @ViewBuilder centerContent: @escaping () -> CenterContent? = { EmptyView() },
       @ViewBuilder trailingContent: @escaping () -> TrailingContent? = { EmptyView() },
       isDividerShown: Bool = true) {
    self.leadingContent = leadingContent
    self.centerContent = centerContent
    self.trailingContent = trailingContent
    self.isDividerShown = isDividerShown
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
      
      if isDividerShown {
        VStack {
          Spacer()
          Divider()
            .overlay(Color.fwGray30)
        }
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

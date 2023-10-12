//
//  BottomNavigationContainerButton.swift
//  Synergy
//
//  Created by 이승기 on 2023/09/10.
//

import SwiftUI

struct BottomNavigationContainerButton<Destination>: View where Destination: View {
  
  // MARK: - Properties
  
  @EnvironmentObject private var tabBarConfig: TabBarConfig
  
  private let text: String
  @Binding var enabled: Bool
  private let destination: () -> Destination
  
  
  // MARK: - Initializers
  
  init(_ text: String,
       enabled: Binding<Bool>,
       @ViewBuilder destination: @escaping () -> Destination) {
    self.text = text
    _enabled = enabled
    self.destination = destination
  }
  
  
  // MARK: - Views
  
  var body: some View {
    ZStack {
      VStack {
        Divider()
          .overlay(Color.fwGray40)
        
        Spacer()
      }
      
      NavigationLink {
        destination()
      } label: {
        Text(text)
          .font(.system(size: 15, weight: .bold))
          .foregroundColor(.fwWhite)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background(
            Color(uiColor: enabled ? R.color.black()! : R.color.gray40()!)
              .frame(maxWidth: .infinity, maxHeight: 52)
              .cornerRadius(12)
          )
      }
      .padding(.horizontal, 16)
      .disabled(!enabled)
    }
    .frame(height: 76)
    .background(Color.fwWhite.ignoresSafeArea())
    .toolbar(.hidden, for: .navigationBar)
    .toolbar(.hidden, for: .tabBar)
    .onAppear {
      tabBarConfig.isTabBarHidden = true
    }
  }
}

struct BottomNavigationContainerButton_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      VStack {
        Spacer()
        
        BottomContainerButton("text", enabled: .constant(true)) {
          Text("test destination")
        }
      }
      .background(Color.gray)
    }
  }
}

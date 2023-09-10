//
//  BottomContainerButton.swift
//  freewill
//
//  Created by 이승기 on 2023/09/10.
//

import SwiftUI

struct BottomContainerButton: View {
  
  // MARK: - Properties
  
  private let text: String
  @Binding var enabled: Bool
  private let action: () -> Void
  
  
  // MARK: - Initializers
  
  init(_ text: String,
       enabled: Binding<Bool>,
       action: @escaping () -> Void) {
    self.text = text
    _enabled = enabled
    self.action = action
  }
  
  
  // MARK: - Views
  
  var body: some View {
    ZStack {
      VStack {
        Divider()
          .overlay(Color.fwGray30)
        
        Spacer()
      }
      
      Button {
        action()
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
  }
}

struct BottomContainerButton_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      Spacer()
      
      BottomContainerButton("text", enabled: .constant(true)) {
        // action
      }
    }
    .background(Color.gray)
  }
}

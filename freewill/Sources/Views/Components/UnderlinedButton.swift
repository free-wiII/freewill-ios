//
//  UnderlinedButton.swift
//  freewill
//
//  Created by 이승기 on 2023/09/10.
//

import SwiftUI

struct UnderlinedButton: View {
  
  // MARK: - Properties
  
  private let text: String
  private let action: () -> Void
  
  
  // MARK: - Initializers
  
  init(_ text: String,
       action: @escaping () -> Void) {
    self.text = text
    self.action = action
  }
  
  
  // MARK: - Views
  
  var body: some View {
    Button {
      // logout action
    } label: {
      Text(text)
        .font(.system(size: 15))
        .foregroundColor(.fwGray60)
        .underline()
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
    }
  }
}


// MARK: - Preview

struct UnderlinedButton_Preview: PreviewProvider {
  
  static var previews: some View {
    UnderlinedButton("로그아웃") {
      // action
    }
  }
}

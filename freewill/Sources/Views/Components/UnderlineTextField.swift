//
//  UnderlineTextField.swift
//  freewill
//
//  Created by 이승기 on 2023/09/10.
//

import SwiftUI

struct UnderlineTextField: View {
  
  // MARK: - Properties
  
  public var placeholder: String
  @Binding public var text: String
  @State private var isFocused: Bool
  
  
  // MARK: - LifeCycle
  
  public init(placeholder: String = "",
              text: Binding<String>,
              focused: Bool = false) {
    self.placeholder = placeholder
    self._text = text
    self.isFocused = focused
  }
  
  
  // MARK: - Views
  
  public var body: some View {
    VStack {
      FocusableTextField(placeholder: placeholder,
                         text: $text,
                         focused: $isFocused)
      .foregroundColor(isFocused ? .fwBlack : .fwGray60)
      .font(.system(size: 17))
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .padding(.horizontal, 8)
      
      Divider()
        .frame(minHeight: 1)
        .background(isFocused ? Color.fwBlack : Color.fwGray30)
    }
    .frame(height: 48)
  }
}

struct NKTextField_Previews: PreviewProvider {
  static var previews: some View {
    @State var text = ""
    UnderlineTextField(placeholder: "placeholder", text: $text)
  }
}

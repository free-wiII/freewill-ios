//
//  FocusableTextField.swift
//  Synergy
//
//  Created by 이승기 on 2023/09/10.
//

import SwiftUI
import UIKit

struct FocusableTextField: UIViewRepresentable {
  
  // MARK: - Properties
  
  var placeholder = ""
  @Binding var text: String
  @Binding var focused: Bool
  
  
  // MARK: - LifeCycle
  
  func makeUIView(context: Context) -> UITextField {
    let textField = UITextField()
    textField.placeholder = placeholder
    
    textField.delegate = context.coordinator
    textField.addTarget(context.coordinator, action: #selector(Coordinator.textFieldEditingChanged(_:)), for: .editingChanged)
    
    return textField
  }
  
  func updateUIView(_ uiView: UITextField, context: Context) {
    uiView.text = text
    uiView.placeholder = placeholder
    
    DispatchQueue.main.asyncAfter(deadline: .now()) {
      if focused {
        uiView.becomeFirstResponder()
      } else {
        uiView.resignFirstResponder()
      }
    }
  }
  
  
  // MARK: - Coordinator
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  class Coordinator: NSObject, UITextFieldDelegate {
    var parent: FocusableTextField
    
    init(_ textField: FocusableTextField) {
      self.parent = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
      parent.focused = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
      parent.focused = false
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
      parent.text = textField.text ?? ""
    }
  }
}


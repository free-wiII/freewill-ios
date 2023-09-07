//
//  BlurView.swift
//  freewill
//
//  Created by 이승기 on 2023/09/07.
//

import SwiftUI
import UIKit

struct BlurView: UIViewRepresentable {
  
  func makeUIView(context: Context) -> some UIView {
    let effect = UIBlurEffect(style: .light)
    return UIVisualEffectView(effect: effect)
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) { }
}

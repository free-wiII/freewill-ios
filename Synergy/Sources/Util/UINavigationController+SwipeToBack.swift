//
//  UINavigationController+SwipeToBack.swift
//  freewill
//
//  Created by 이승기 on 2023/09/18.
//

import UIKit

extension UINavigationController: UIGestureRecognizerDelegate {
  open override func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.delegate = self
  }
  
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return viewControllers.count > 1
  }
}

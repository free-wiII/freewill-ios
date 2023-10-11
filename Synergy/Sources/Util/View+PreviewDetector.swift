//
//  View+PreviewDetector.swift
//  Synergy
//
//  Created by 이승기 on 2023/10/11.
//

import SwiftUI

extension View {
  public var isPreview: Bool {
    return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
  }
}

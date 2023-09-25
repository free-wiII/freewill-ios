//
//  Float+AsTwoDecimalString.swift
//  Synergy
//
//  Created by 이승기 on 2023/09/22.
//

import Foundation

extension Float {
  var asTwoDecimalString: String {
    return String(format: "%.2f", self)
  }
}

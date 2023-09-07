//
//  MainViewModel.swift
//  freewill
//
//  Created by 이승기 on 2023/09/07.
//

import SwiftUI

final class MainViewModel: ObservableObject {
  
  // MARK: - Properties
  
  @Published var selectedCriteria: FilterCriteria = .best
}

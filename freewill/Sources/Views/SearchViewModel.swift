//
//  SearchViewModel.swift
//  freewill
//
//  Created by 이승기 on 2023/09/08.
//

import SwiftUI

final class SearchViewModel: ObservableObject {
  
  // MARK: - Properties
  
  @Published var selectedPriority = [Rating]()
  
  
  // MARK: - Public
  
  public func addPriority(_ rating: Rating) {
    // 중복된 거 있으면 삭제
    removePriority(rating)
    
    // 최대 선택가능 갯수 3개
    if selectedPriority.count >= 3 {
      selectedPriority.removeLast()
    }
    
    selectedPriority.append(rating)
  }
  
  public func removePriority(_ rating: Rating) {
    if let index = selectedPriority.firstIndex(of: rating) {
      selectedPriority.remove(at: index)
    }
  }
}

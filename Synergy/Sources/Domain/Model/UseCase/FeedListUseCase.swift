//
//  FeedListUseCase.swift
//  freewill
//
//  Created by 이승기 on 2023/09/10.
//

import Foundation
import Combine

final class FeedListUseCase {
  
  // MARK: - Properties
  
  private let repository: FreeWillRepository
  
  
  // MARK: - Initializers
  
  init(_ repository: FreeWillRepository) {
    self.repository = repository
  }
  
  
  // MARK: - Methods
  
  func execute(page: Int) -> AnyPublisher<[Feed], Error> {
    return repository.fetchFeed(page: page)
  }
}

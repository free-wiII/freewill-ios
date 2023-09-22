//
//  ReviewListUseCase.swift
//  freewill
//
//  Created by 이승기 on 2023/09/22.
//

import Foundation
import Combine

final class ReviewListUseCase {
  
  // MARK: - Properties
  
  private let repository: FreeWillRepository
  
  
  // MARK: - Initializers
  
  init(repository: FreeWillRepository) {
    self.repository = repository
  }
  
  
  // MARK: - Methods
  
  public func execute() -> AnyPublisher<[Review], Error> {
    return repository.fetchReviewList()
  }
}

//
//  CafeDetailUseCase.swift
//  freewill
//
//  Created by 이승기 on 2023/09/22.
//

import Combine

final class CafeDetailUseCase {
  
  // MARK: - Properties
  
  private let repository: FreeWillRepository
  
  
  // MARK: - Initializers
  
  init(repository: FreeWillRepository) {
    self.repository = repository
  }
  
  
  // MARK: - Methods
  
  public func execute() -> AnyPublisher<CafeDetail, Error> {
    return repository.fetchCafeDetail()
  }
}

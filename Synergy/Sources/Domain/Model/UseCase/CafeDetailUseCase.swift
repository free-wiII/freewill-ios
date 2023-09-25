//
//  CafeDetailUseCase.swift
//  Synergy
//
//  Created by 이승기 on 2023/09/22.
//

import Combine

final class CafeDetailUseCase {
  
  // MARK: - Properties
  
  private let repository: SynergyRepository
  
  
  // MARK: - Initializers
  
  init(repository: SynergyRepository) {
    self.repository = repository
  }
  
  
  // MARK: - Methods
  
  public func execute() -> AnyPublisher<CafeDetail, Error> {
    return repository.fetchCafeDetail()
  }
}

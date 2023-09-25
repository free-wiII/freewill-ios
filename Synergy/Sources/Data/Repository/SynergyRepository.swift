//
//  SynergyRepository.swift
//  Synergy
//
//  Created by 이승기 on 2023/09/15.
//

import UIKit
import Combine

final class SynergyRepository {
  
  // MARK: - Properties
  
  private let service: NetworkService<SynergyAPI>
  
  
  // MARK: - Initializers
  
  init(service: NetworkService<SynergyAPI>) {
    self.service = service
  }
  
  
  // MARK: - Methods
  
  public func fetchFeed(page: Int) -> AnyPublisher<[Feed], Error> {
    return service
      .request(.fetchFeed(page: page), type: FeedEntityResponse.self)
      .map { $0.map { $0.toDomain() } }
      .eraseToAnyPublisher()
  }
  
  public func fetchCafeDetail() -> AnyPublisher<CafeDetail, Error> {
    return service
      .request(.fetchCafeDetail, type: CafeDetailEntity.self)
      .map { $0.toDomain() }
      .eraseToAnyPublisher()
  }
  
  public func fetchReviewList() -> AnyPublisher<[Review], Error> {
    return service
      .request(.fetchReviewList, type: ReviewListResponse.self)
      .map { $0.map { $0.toDomain() } }
      .eraseToAnyPublisher()
  }
}

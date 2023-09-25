//
//  FreeWillRepository.swift
//  freewill
//
//  Created by 이승기 on 2023/09/15.
//

import UIKit
import Combine

final class FreeWillRepository {
  
  // MARK: - Properties
  
  private let service: NetworkService<FreeWillAPI>
  
  
  // MARK: - Initializers
  
  init(service: NetworkService<FreeWillAPI>) {
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

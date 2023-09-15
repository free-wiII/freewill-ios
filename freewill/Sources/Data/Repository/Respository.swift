//
//  FreeWillRepository.swift
//  freewill
//
//  Created by 이승기 on 2023/09/15.
//

import UIKit
import Combine

final class FreeWillRepository {
  
  private let service: NetworkService<FreeWillAPI>
  
  init(service: NetworkService<FreeWillAPI>) {
    self.service = service
  }
  
  public func fetchFeed() -> AnyPublisher<[Feed], Error> {
    return service
      .request(.fetchFeed, type: FeedEntityResponse.self)
      .map { $0.map { $0.toDomain() } }
      .eraseToAnyPublisher()
  }
}

//
//  UserRepository.swift
//  freewill
//
//  Created by 이승기 on 2023/09/16.
//

import UIKit
import Combine

final class UserRepository {
   
  // MARK: - Properties
  
  private let service: NetworkService<UserAPI>
  
  
  // MARK: - Initializers
  
  init(service: NetworkService<UserAPI>) {
    self.service = service
  }
  
  
  // MARK: - Methods
  
  public func fetchBookmarkGroup() -> AnyPublisher<[BookmarkGroup], Error> {
    return service
      .request(.fetchBookmark, type: BookmarkGroupResponse.self)
      .map { $0.map { $0.toDomain() } }
      .eraseToAnyPublisher()
  }
}

//
//  BookmarkRepository.swift
//  Synergy
//
//  Created by 이승기 on 2023/09/17.
//

import UIKit
import Combine

final class BookmarkRepository {
  
  // MARK: - Properties
  
  private let service: NetworkService<BookmarkAPI>
  
  
  // MARK: - Initializers
  
  init(service: NetworkService<BookmarkAPI>) {
    self.service = service
  }
  
  
  // MARK: - Methods
  
  public func fetchBookmark() -> AnyPublisher<[Bookmark], Error> {
    return service
      .request(.fetchBookmark, type: BookmarkResponse.self)
      .map { $0.map { $0.toEntity() } }
      .eraseToAnyPublisher()
  }
}

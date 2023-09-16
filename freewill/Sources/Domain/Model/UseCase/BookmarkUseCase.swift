//
//  BookmarkUseCase.swift
//  freewill
//
//  Created by 이승기 on 2023/09/17.
//

import Foundation
import Combine

final class BookmarkUseCase {
  
  // MARK: - Properties
  
  private let repository: BookmarkRepository
  
  
  // MARK: - Initializers
  
  init(repository: BookmarkRepository) {
    self.repository = repository
  }
  
  
  // MARK: - Methods
  
  func execute() -> AnyPublisher<[Bookmark], Error> {
    return repository.fetchBookmark()
  }
}

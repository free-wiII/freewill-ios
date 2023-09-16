//
//  BookmarkGroupUseCase.swift
//  freewill
//
//  Created by 이승기 on 2023/09/16.
//

import Foundation
import Combine

final class BookmarkGroupUseCase {
  
  // MARK: - Properties
  
  private let repository: BookmarkGroupRepository
  
  
  // MARK: - Initializers
  
  init(repository: BookmarkGroupRepository) {
    self.repository = repository
  }
  
  
  // MARK: - Methods
  
  func execute() -> AnyPublisher<[BookmarkGroup], Error> {
    return repository.fetchBookmarkGroup()
  }
}

//
//  BookmarkViewModel.swift
//  freewill
//
//  Created by 이승기 on 2023/09/16.
//

import SwiftUI
import Combine

final class BookmarkViewModel: ObservableObject {
  
  // MARK: - Properties
  
  private var cancellables = Set<AnyCancellable>()
  
  @Published var bookmarkGroups = [BookmarkGroup]()
  
  private let bookmarkGroupUseCase: BookmarkGroupUseCase
  
  
  // MARK: - Initializers
  
  init() {
    let repository = UserRepository(service: NetworkService<UserAPI>(.stub))
    bookmarkGroupUseCase = BookmarkGroupUseCase(repository: repository)
  }
  
  
  // MARK: - Methods
  
  public func fetchBookmarkGroup() {
    bookmarkGroupUseCase.execute()
      .subscribe(on: DispatchQueue.global())
      .receive(on: DispatchQueue.main)
      .sink { _ in
        // completion
      } receiveValue: { [weak self] bookmarkGroups in
        self?.bookmarkGroups = bookmarkGroups
      }
      .store(in: &cancellables)
  }
}

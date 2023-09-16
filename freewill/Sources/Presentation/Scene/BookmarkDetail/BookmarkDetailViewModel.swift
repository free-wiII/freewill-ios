//
//  BookmarkDetailViewModel.swift
//  freewill
//
//  Created by 이승기 on 2023/09/17.
//

import SwiftUI
import Combine

final class BookmarkDetailViewModel: ObservableObject {
  
  // MARK: - Properties
  
  private var cancellables = Set<AnyCancellable>()
  
  @Published var isLoading = false
  @Published var bookmarks = [Bookmark]()
  
  private let bookmarkUseCase: BookmarkUseCase
  
  
  // MARK: - Initializers
  
  init() {
    let repository = BookmarkRepository(service: .init(.stub))
    bookmarkUseCase = BookmarkUseCase(repository: repository)
  }
  
  
  // MARK: - Methods
  
  public func fetchBookmarks() {
    isLoading = true
    
    bookmarkUseCase.execute()
      .subscribe(on: DispatchQueue.global())
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        self?.isLoading = false
      } receiveValue: { [weak self] bookmarks in
        self?.bookmarks = bookmarks
      }
      .store(in: &cancellables)
  }
}

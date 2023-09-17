//
//  SaveCafeViewModel.swift
//  freewill
//
//  Created by 이승기 on 2023/09/17.
//

import SwiftUI
import Combine

final class SaveCafeViewModel: ObservableObject {
  
  // MARK: - Properties
  
  private var cancellables = Set<AnyCancellable>()
  
  @Published var selectedGroup: BookmarkGroup?
  @Published var bookmarkGroups = [BookmarkGroup]()
  
  private let bookmarkGroupUseCase: BookmarkGroupUseCase
  
  
  // MARK: - Initializers
  
  init() {
    let repository = BookmarkGroupRepository(service: NetworkService<BookmarkAPI>(.stub))
    bookmarkGroupUseCase = BookmarkGroupUseCase(repository: repository)
  }
  
  
  // MARK: - Methods
  
  public func fetchBookmarkGroups() {
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

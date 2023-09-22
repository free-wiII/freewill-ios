//
//  ReviewListViewModel.swift
//  freewill
//
//  Created by 이승기 on 2023/09/22.
//

import SwiftUI
import Combine

final class ReviewListViewModel: ObservableObject {
  
  // MARK: - Properties
  
  private let reviewListUseCase: ReviewListUseCase
  
  private var cancellables = Set<AnyCancellable>()
  
  @Published var isLoading = false
  @Published var reviews = [Review]()
  
  
  // MARK: - Initializers
  
  init() {
    let repository = FreeWillRepository(service: .init(.stub))
    self.reviewListUseCase = ReviewListUseCase(repository: repository)
  }
  
  
  // MARK: - Methods
  
  public func fetchReviewList() {
    isLoading = true
    
    reviewListUseCase
      .execute()
      .subscribe(on: DispatchQueue.global())
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        print(completion)
        self?.isLoading = false
      } receiveValue: { [weak self] reviews in
        self?.reviews = reviews
      }
      .store(in: &cancellables)
  }
}

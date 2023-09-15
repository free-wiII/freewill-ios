//
//  MainViewModel.swift
//  freewill
//
//  Created by 이승기 on 2023/09/07.
//

import SwiftUI
import Combine

final class MainViewModel: ObservableObject {
  
  // MARK: - Properties
  
  private var cancellables = Set<AnyCancellable>()
  
  @Published var selectedCriteria: FilterCriteria = .best
  @Published var feeds = [Feed]()
  
  private let feedListUseCase: FeedListUseCase
  
  
  // MARK: - Initializers
  
  init() {
    let repository = FreeWillRepository(service: NetworkService(.stub))
    feedListUseCase = FeedListUseCase(repository)
  }
  
  
  // MARK: - Methods
  
  public func fetchFeed() {
    feedListUseCase.execute()
      .subscribe(on: DispatchQueue.global())
      .receive(on: DispatchQueue.main)
      .sink { completion in
        print(completion)
      } receiveValue: { [weak self] feeds in
        self?.feeds = feeds
      }
      .store(in: &cancellables)
  }
}

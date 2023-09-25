//
//  MainViewModel.swift
//  Synergy
//
//  Created by 이승기 on 2023/09/07.
//

import SwiftUI
import Combine

final class FeedViewModel: ObservableObject {
  
  // MARK: - Properties
  
  private var cancellables = Set<AnyCancellable>()
  
  @Published var isFirstPageLoading = false
  @Published var selectedCriteria: FilterCriteria = .best
  @Published var feeds = [Feed]()
  
  private let feedListUseCase: FeedListUseCase
  private var page = 0
  
  
  // MARK: - Initializers
  
  init() {
    let repository = SynergyRepository(service: NetworkService<SynergyAPI>(.stub))
    feedListUseCase = FeedListUseCase(repository)
  }
  
  
  // MARK: - Methods
  
  public func fetchFeed() {
    page += 1
    
    if page == 1 {
      isFirstPageLoading = true
    }
    
    feedListUseCase.execute(page: page)
      .subscribe(on: DispatchQueue.global())
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        self?.isFirstPageLoading = false
      } receiveValue: { [weak self] feeds in
        self?.feeds.append(contentsOf: feeds)
      }
      .store(in: &cancellables)
  }
}

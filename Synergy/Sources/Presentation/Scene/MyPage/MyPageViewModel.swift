//
//  MyPageViewModel.swift
//  Synergy
//
//  Created by 이승기 on 10/24/23.
//

import SwiftUI
import Combine

final class MyPageViewModel: ObservableObject {
  
  // MARK: - Properties
  
  private var cancellables = Set<AnyCancellable>()

  private let profileUseCase: ProfileUseCase
  
  @Published private(set) var profile: Profile? = nil
  @Published private(set) var isLoading = false
  @Published private(set) var failToGetProfile = false
  
  
  // MARK: - Initializers
  
  init() {
    let service = NetworkService<ProfileAPI>(.server)
    let repository = ProfileRepository(service: service)
    let profileUseCase = ProfileUseCase(repository: repository)
    self.profileUseCase = profileUseCase
  }
  
  
  // MARK: - public
  
  public func fetchProfile() {
    isLoading = true
    
    let tokenKeychain = TokenKeyChain()
    if let idToken = tokenKeychain.read(tokenType: .accessToken) {
      profileUseCase.execute(accessToken: idToken)
        .subscribe(on: DispatchQueue.global())
        .receive(on: DispatchQueue.main)
        .sink { [weak self] completion in
          switch completion {
          case .failure(let error):
            print(error)
            self?.failToGetProfile = true
            
          case .finished:
            self?.isLoading = false
          }
        } receiveValue: { [weak self] profile in
          self?.profile = profile
        }
        .store(in: &cancellables)
    } else {
      // 토큰 만료 -> 다시 로그인해서 토큰 재발급 받도록 로그인 뷰 표시
      failToGetProfile = true
    }
  }
}

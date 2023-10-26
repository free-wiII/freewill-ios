//
//  ProfileUseCase.swift
//  Synergy
//
//  Created by 이승기 on 10/24/23.
//

import Foundation
import Combine

final class ProfileUseCase {
  
  // MARK: - Properties
  
  private let repository: ProfileRepository
  
  
  // MARK: - Initializers
  
  init(repository: ProfileRepository) {
    self.repository = repository
  }
  
  
  // MARK: - Methods
  
  public func execute(accessToken: String) -> AnyPublisher<Profile, Error> {
    return repository.fetchProfile(accessToke: accessToken)
  }
}

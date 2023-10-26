//
//  ProfileRepository.swift
//  Synergy
//
//  Created by 이승기 on 10/24/23.
//

import Foundation
import Combine

final class ProfileRepository {
  
  // MARK: - Properties
  
  private let service: NetworkService<ProfileAPI>
  
  
  // MARK: - Initializers
  
  init(service: NetworkService<ProfileAPI>) {
    self.service = service
  }
  
  
  // MARK: - Methods
  
  public func fetchProfile(accessToke: String) -> AnyPublisher<Profile, Error> {
    return service
      .request(.profile(accessToken: accessToke), type: ProfileEntity.self)
      .map { $0.toDomain() }
      .eraseToAnyPublisher()
  }
}

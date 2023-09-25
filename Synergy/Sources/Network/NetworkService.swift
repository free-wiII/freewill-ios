//
//  NetworkService.swift
//  Synergy
//
//  Created by 이승기 on 2023/09/15.
//

import Foundation
import Moya
import Combine
import CombineMoya

enum NetworkServiceType {
  case server
  case stub
}

final class NetworkService<Target: TargetType> {
  
  // MARK: - Properties
  
  private let provider: MoyaProvider<Target>
  private let decoder = JSONDecoder()

  
  // MARK: - Initializers
  
  init(_ serviceType: NetworkServiceType) {
    switch serviceType {
    case .server:
      provider = MoyaProvider<Target>()
    case .stub:
      provider = MoyaProvider<Target>(stubClosure: MoyaProvider.delayedStub(1.0))
    }
  }
  
  
  // MARK: - Publics
  
  public func request<T: Decodable>(_ target: Target, type: T.Type) -> AnyPublisher<T, Error> {
    provider
      .requestPublisher(target)
      .map(\.data)
      .decode(type: T.self, decoder: decoder)
      .eraseToAnyPublisher()
  }
}

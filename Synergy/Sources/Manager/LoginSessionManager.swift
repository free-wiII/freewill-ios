//
//  LoginSessionManager.swift
//  Synergy
//
//  Created by 이승기 on 10/28/23.
//

import Foundation

final class LoginSessionManager {
  
  // MARK: - Public
  
  public func isLoggedIn() -> Bool {
    let tokenKeyChain = TokenKeyChain()
    if tokenKeyChain.read(tokenType: .idToken) == nil {
      // 로그인 되어있음
      return false
    } else {
      // 로그인 되어있지 않음
      return true
    }
  }
  
  public func logout() {
    let tokenKeyChain = TokenKeyChain()
    tokenKeyChain.delete(tokenType: .idToken)
    tokenKeyChain.delete(tokenType: .accessToken)
    tokenKeyChain.delete(tokenType: .refreshToken)
  }
  
  public func validateAccessToken() {
    // 1. access token 만료되었는지 확인
    // 2. refresh token을 이용해서 새로운 access token 발급
  }
}

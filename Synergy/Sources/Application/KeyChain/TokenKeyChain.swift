//
//  TokenKeyChain.swift
//  Synergy
//
//  Created by 이승기 on 10/21/23.
//

import Foundation
import Security

struct TokenKeyChain {
  
  // MARK: - Properties
  
  enum TokenType {
    case accessToken
    case refreshToken
    
    var key: String {
      switch self {
      case .accessToken:
        return "com.synergy.accessToken"
      case .refreshToken:
        return "com.synergy.refreshToken"
      }
    }
  }
  
  
  // MARK: - Methods
  
  public func save(tokenType: TokenType, value: String) {
    let query: NSDictionary = [
      kSecClass: kSecClassKey,
      kSecAttrAccount: tokenType.key,
      kSecValueData: value
    ]
    
    SecItemDelete(query)
    
    let status = SecItemAdd(query, nil)
    assert(status == noErr, "failed to save idToken")
  }

  public func read(tokenType: TokenType) -> String? {
    let query: NSDictionary = [
      kSecClass: kSecClassKey,
      kSecAttrAccount: tokenType.key,
      kSecReturnData: kCFBooleanTrue as Any,
      kSecMatchLimit: kSecMatchLimitOne
    ]
    
    var dataTypeRef: AnyObject?
    let status = SecItemCopyMatching(query, &dataTypeRef)
    
    if status == errSecSuccess {
      let retrievedData = dataTypeRef as! Data
      let value = String(data: retrievedData, encoding: String.Encoding.utf8)
      return value
    } else {
      print("failed to loading, status code = \(status)")
      return nil
    }
  }
  
  public func delete(tokenType: TokenType) {
    let query: NSDictionary = [
      kSecClass: kSecClassKey,
      kSecAttrAccount: tokenType.key
    ]
    
    let status = SecItemDelete(query)
    assert(status == noErr, "fail to delete token")
  }
}

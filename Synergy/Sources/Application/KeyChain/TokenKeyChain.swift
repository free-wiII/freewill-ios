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
    case idToken
    
    var key: String {
      switch self {
      case .accessToken:
        return "com.synergy.accessToken"
      case .refreshToken:
        return "com.synergy.refreshToken"
      case .idToken:
        return "com.synergy.idToken"
      }
    }
  }
  
  let serviceId = "com.synergy"
  
  
  // MARK: - Methods
  
  public func create(tokenType: TokenType, value: String) {
    // 쿼리 생성
    let query: NSDictionary = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrService: serviceId,
      kSecAttrAccount: tokenType.key,
      kSecValueData: value.data(using: .utf8, allowLossyConversion: false)!
    ]
    
    // 이미 값이 존재한다면 삭제
    SecItemDelete(query)
    
    // 값 저장
    let status = SecItemAdd(query, nil)
    assert(status == noErr, "failed to save idToken")
  }

  public func read(tokenType: TokenType) -> String? {
    // 쿼리 생성
    let query: NSDictionary = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrService: serviceId,
      kSecAttrAccount: tokenType.key,
      kSecReturnData: kCFBooleanTrue as Any,
      kSecMatchLimit: kSecMatchLimitOne
    ]
    
    // 불러오기
    var dataTypeRef: AnyObject?
    let status = SecItemCopyMatching(query, &dataTypeRef)
    
    if status == errSecSuccess {
      // 성공
      let retrievedData = dataTypeRef as! Data
      let value = String(data: retrievedData, encoding: String.Encoding.utf8)
      return value
    } else {
      // 실패
      print("failed to loading, status code = \(status)")
      return nil
    }
  }
  
  public func delete(tokenType: TokenType) {
    // 쿼리 생성
    let query: NSDictionary = [
      kSecClass: kSecClassKey,
      kSecAttrAccount: tokenType.key
    ]
    
    // 삭제
    let status = SecItemDelete(query)
    assert(status == noErr, "fail to delete token")
  }
}

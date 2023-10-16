//
//  SynergyApp.swift
//  freewill
//
//  Created by 이승기 on 2023/09/06.
//

import SwiftUI

import KakaoSDKCommon
import KakaoSDKAuth

import GoogleSignIn

@main
struct SynergyApp: App {
  
  // MARK: - Initializers
  
  init() {
    setup()
  }
  
  
  // MARK: - Views
  
  var body: some Scene {
    WindowGroup {
      MainTabbedView().onOpenURL(perform: { url in
        if AuthApi.isKakaoTalkLoginUrl(url) {
          _ = AuthController.handleOpenUrl(url: url)
        }
        
        GIDSignIn.sharedInstance.handle(url)
      })
    }
  }
  
  // MARK: - Methods
  
  private func setup() {
    initKakaoSDK()
  }
  
  private func initKakaoSDK() {
    guard let url = Bundle.main.url(forResource: "Info", withExtension: "plist"),
          let dictionary = NSDictionary(contentsOf: url) else {
      return
    }
    
    if let appKey = dictionary["KAKAO_APP_KEY"] as? String {
      KakaoSDK.initSDK(appKey: appKey)
    }
  }
}

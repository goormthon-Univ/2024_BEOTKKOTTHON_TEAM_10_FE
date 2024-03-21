//
//  LogoutService.swift
//  CenApp
//
//  Created by 정성윤 on 2024/03/21.
//

import Foundation
import SwiftKeychainWrapper
import UIKit
class LogoutService {
    static func requestLogout() {
        //저장된 모든 키체인을 삭제 -> 온보딩은 UserDefault/서버에서 관리
        KeychainWrapper.standard.removeAllKeys()
        //로그인 화면이 루트뷰로 설정
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            let loginViewController = LoginViewController()
            sceneDelegate.window?.rootViewController = loginViewController
        }
    }
}

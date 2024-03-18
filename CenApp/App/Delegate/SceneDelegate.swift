//
//  SceneDelegate.swift
//  CenApp
//
//  Created by 김민솔 on 3/16/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        let onboard = UINavigationController(rootViewController: IncomeViewController())
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = onboard
        window?.makeKeyAndVisible()

    }

 

}


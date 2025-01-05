//
//  SceneDelegate.swift
//  Lesson3_2
//
//  Created by Evgeny Mastepan on 04.01.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: scene)
        self.window?.rootViewController = UINavigationController(rootViewController: TabBarView())
        self.window?.makeKeyAndVisible()
    }
}


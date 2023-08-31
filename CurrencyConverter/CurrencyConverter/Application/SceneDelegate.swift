//
//  SceneDelegate.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var appCoordinator: AppCoordinatorProtocol?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        window.makeKeyAndVisible()
        window.overrideUserInterfaceStyle = .light
        self.appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

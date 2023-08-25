//
//  AppCoordinator.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import Foundation
import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    var window: UIWindow { get }
    func openTabBar()
}

class AppCoordinator: AppCoordinatorProtocol {
    
    weak var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        openTabBar()
    }
    
    func openTabBar() {
        let tabBarCoordinator = TabBarCoordinator(tabBarController: TabBarController())
        window.rootViewController = tabBarCoordinator.tabBarController
        addChildCoordinator(tabBarCoordinator)
        tabBarCoordinator.start()
    }
    
}

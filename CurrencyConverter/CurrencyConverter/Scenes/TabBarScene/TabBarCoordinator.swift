//
//  TabBarCoordinator.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import Foundation
import UIKit

protocol TabBarCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get }
}

class TabBarCoordinator: TabBarCoordinatorProtocol {

    let tabBarController: UITabBarController
    
    weak var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        addCurrencyListPage()
        addWalletPage()
        addBidsPage()
        addSettingsPage()
    }
    
    func addCurrencyListPage() {
        let coordinator = CurrencyListCoordinator(navigationController: UINavigationController())
        tabBarController.viewControllers?.append(coordinator.navigationController)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
    
    func addSettingsPage() {
        let coordinator = SettingsCoordinator(navigationController: UINavigationController())
        tabBarController.viewControllers?.append(coordinator.navigationController)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
    
    func addWalletPage() {
        let coordinator = WalletCoordinator(navigationController: UINavigationController())
        tabBarController.viewControllers?.append(coordinator.navigationController ?? UINavigationController())
        addChildCoordinator(coordinator)
        coordinator.start()
    }
    
    func addBidsPage() {
        let coordinator = BidsCoordinator(navigationController: UINavigationController())
        tabBarController.viewControllers?.append(coordinator.navigationController ?? UINavigationController())
        addChildCoordinator(coordinator)
        coordinator.start()
    }
    
    func finish() {
        tabBarController.viewControllers?.removeAll()
        childCoordinators.removeAll()
        parentCoordinator?.removeChildCoordinator(self)
    }
}

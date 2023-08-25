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
    func addFirstPage()
}

class TabBarCoordinator: TabBarCoordinatorProtocol {

    let tabBarController: UITabBarController
    
    weak var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        addFirstPage()
        addSecondPage()
    }
    
    func addFirstPage() {
        let coordinator = CurrencyListCoordinator(navigationController: UINavigationController())
        tabBarController.viewControllers?.append(coordinator.navigationController)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
    
    func addSecondPage() {
        let coordinator = SettingsCoordinator(navigationController: UINavigationController())
        tabBarController.viewControllers?.append(coordinator.navigationController)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
    
    func finish() {
        tabBarController.viewControllers?.removeAll()
        childCoordinators.removeAll()
        parentCoordinator?.removeChildCoordinator(self)
    }
}

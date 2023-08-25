//
//  SettingsCoordinator.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import UIKit

class SettingsCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    weak var parentCoordinator: Coordinator?
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setupPrimaryNavBar()
    }
    
    func start() {
        let viewModel = SettingsViewModel()
        let viewController = SettingsViewController(viewModel: viewModel)
        viewController.addNavItemTitle(text: "Settings", font: .montserratSemibold, fontSize: 17)
        viewController.openSelectedCurrency = { [weak self] in
            self?.openSelectedCurrencyController()
        }
        viewController.navigationItem.backButtonTitle = ""
        navigationController.tabBarItem = UITabBarItem(title: nil,
                                                       image: TabBarItems.settings.image,
                                                       selectedImage: nil)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func openSelectedCurrencyController() {
        let viewModel = SettingsViewModel()
        let viewController = SelectedCurrencyViewController(viewModel: viewModel)
        viewController.addNavItemTitle(text: "Selected Currency", font: .montserratSemibold, fontSize: 17)
        viewController.hidesBottomBarWhenPushed = true
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

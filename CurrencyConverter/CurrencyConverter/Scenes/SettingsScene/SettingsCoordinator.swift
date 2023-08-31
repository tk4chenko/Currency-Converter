//
//  SettingsCoordinator.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import UIKit

protocol SettingsCoordinatorDelegate: AnyObject {
    func openSelectedCurrencyController()
}

class SettingsCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    weak var parentCoordinator: Coordinator?
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setupPrimaryNavBar()
    }
    
    func start() {
        let viewModel = SettingsViewModel(currencyManager: CurrencyManager())
        viewModel.coordinateDelegate = self
        let viewController = SettingsViewController(viewModel: viewModel)
        viewController.addNavItemTitle(text: "Settings", font: .montserratSemibold, fontSize: 17)
        viewController.navigationItem.backButtonTitle = ""
        navigationController.tabBarItem = UITabBarItem(
            title: nil,
            image: TabBarItems.settings.image,
            selectedImage: nil)
        navigationController.tabBarItem.imageInsets = UIEdgeInsets(
            top: 0,
            left: -28,
            bottom: 0,
            right: 28)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func backToPrevious() {
        navigationController.popViewController(animated: true)
    }
}
    
extension SettingsCoordinator: SettingsCoordinatorDelegate {
    
    func openSelectedCurrencyController() {
        let coordinator = SelectedCoordinator(navigationController: navigationController, isSaved: true)
        coordinator.backToPrevious = { [weak self] _ in
            self?.backToPrevious()
        }
        addChildCoordinator(coordinator)
        coordinator.start()
    }
}

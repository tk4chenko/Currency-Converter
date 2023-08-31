//
//  WalletCoordinator.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 25.08.2023.
//

import UIKit

protocol WalletControllerCoordinatorDelegate: AnyObject {
    func openAddOwnedCurrencyController()
}

protocol AddOwnedCurrencyCoordinatorDelegate: AnyObject {
    func openSelectedCurrencyController(with currency: Currency?)
    func popViewController()
    func popToAddOwnedCurrencyController(with currency: Currency)
}

typealias WalletCoordinatorDelegate = AddOwnedCurrencyCoordinatorDelegate & WalletControllerCoordinatorDelegate

final class WalletCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    weak var parentCoordinator: Coordinator?
    
    let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setupPrimaryNavBar()
    }
    
    func start() {
        let viewModel = WalletViewModel(realmManager: RealmManager())
        viewModel.coordinatorDelegate = self
        let viewController = WalletViewController(viewModel: viewModel)
        viewController.navigationItem.backButtonTitle = ""
        viewController.addNavItemTitle(text: "Wallet", font: .montserratSemibold, fontSize: 17)
        navigationController?.tabBarItem = UITabBarItem(title: nil,
                                                        image: TabBarItems.wallet.image,
                                                        selectedImage: nil)
        navigationController?.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: -8)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension WalletCoordinator: WalletCoordinatorDelegate {
    
    func openAddOwnedCurrencyController() {
        let viewModel = AddOwnedCurrencyViewModel(realmManager: RealmManager(), networkServise: CurrencyNetworkService())
        viewModel.coordinatorDelegate = self
        let viewController = AddOwnedCurrencyViewController(viewModel: viewModel)
        viewController.addNavItemTitle(text: "Add Owned Currency", font: .montserratSemibold, fontSize: 17)
        viewController.navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openSelectedCurrencyController(with currency: Currency?) {
        guard let navigationController else { return }
        let coordinator = SelectedCoordinator(navigationController: navigationController, currency: currency, isSaved: false)
        coordinator.backToPrevious = { [weak self] currency in
            if let currency {
                self?.popToAddOwnedCurrencyController(with: currency)
            }
        }
        addChildCoordinator(coordinator)
        coordinator.start()
    }
    
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func popToAddOwnedCurrencyController(with currency: Currency) {
        if let viewControllers = navigationController?.viewControllers {
            for viewController in viewControllers {
                if let addOwnedController = viewController as? AddOwnedCurrencyViewController {
                    addOwnedController.currency = currency
                    navigationController?.popToViewController(addOwnedController, animated: true)
                    break
                }
            }
        }
    }
    
}


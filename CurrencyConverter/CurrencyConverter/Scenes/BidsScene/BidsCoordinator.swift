//
//  BidsCoordinator.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 25.08.2023.
//

import UIKit

class BidsCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    weak var parentCoordinator: Coordinator?
    
    let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setupPrimaryNavBar()
    }
    
    func start() {
        let viewModel = BidsViewModel(realmManager: RealmManager())
        let viewController = BidsViewController(viewModel: viewModel)
        viewController.openAddBidCurrencyController = { [weak self] in
            self?.openAddBidCurrencyController()
        }
        viewController.addNavItemTitle(text: "Bids", font: .montserratSemibold, fontSize: 17)
        viewController.navigationItem.backButtonTitle = ""
        navigationController?.tabBarItem = UITabBarItem(title: nil,
                                                       image: TabBarItems.bids.image,
                                                       selectedImage: nil)
        navigationController?.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func openAddBidCurrencyController() {
        let viewModel = AddBidCurrencyViewModel(realmManager: RealmManager(), networkServise: CurrencyNetworkService())
        let viewController = AddBidCurrencyViewController(viewModel: viewModel)
        viewController.openSelectedCurrencyController = { [weak self] currency in
            self?.openSelectedCurrencyController(with: currency)
        }
        viewController.backToPrevious = { [weak self] in
            self?.popViewController()
        }
        viewController.addNavItemTitle(text: "Add Bid", font: .montserratSemibold, fontSize: 17)
        viewController.navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openSelectedCurrencyController(with currency: Currency? = nil) {
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
    
    private func popToAddOwnedCurrencyController(with currency: Currency) {
        if let viewControllers = navigationController?.viewControllers {
            for viewController in viewControllers {
                if let addBidController = viewController as? AddBidCurrencyViewController {
                    if let direction = addBidController.direction {
                        switch direction {
                        case .from:
                            addBidController.currency.0 = currency
                        case .to:
                            addBidController.currency.1 = currency
                        }
                    }
                    navigationController?.popToViewController(addBidController, animated: true)
                    break
                }
            }
        }
    }
}

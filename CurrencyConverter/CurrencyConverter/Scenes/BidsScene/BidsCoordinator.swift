//
//  BidsCoordinator.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 25.08.2023.
//

import UIKit

protocol BidsControllerCoordinatorDelegate: AnyObject {
    func openAddBidCurrencyController()
}

protocol AddDidCoordinatorDelegate: AnyObject {
    func openSelectedCurrencyController(with currency: Currency?)
    func popViewController()
    func popToAddOwnedCurrencyController(with currency: Currency)
}

typealias BidsCoordinatorDelegate = BidsControllerCoordinatorDelegate & AddDidCoordinatorDelegate

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
        viewModel.coordinatorDelegate = self
        let viewController = BidsViewController(viewModel: viewModel)
        viewController.addNavItemTitle(text: "Bids", font: .montserratSemibold, fontSize: 17)
        viewController.navigationItem.backButtonTitle = ""
        navigationController?.tabBarItem = UITabBarItem(title: nil,
                                                        image: TabBarItems.bids.image,
                                                        selectedImage: nil)
        navigationController?.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 8)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension BidsCoordinator: BidsCoordinatorDelegate {
    
    func openAddBidCurrencyController() {
        let viewModel = AddBidCurrencyViewModel(realmManager: RealmManager(), networkServise: CurrencyNetworkService())
        viewModel.coordinatorDelegate = self
        let viewController = AddBidCurrencyViewController(viewModel: viewModel)
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
    
    func popToAddOwnedCurrencyController(with currency: Currency) {
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

//
//  SelectedCoordinator.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 28.08.2023.
//

import UIKit

protocol SelectedCoordinatorDelegate: AnyObject {
    func backToPrevious(currency: Currency?)
}

final class SelectedCoordinator: Coordinator {

    weak var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    var backToPrevious: ((Currency?)->Void)?
    
    private let navigationController: UINavigationController
    
    private let currency: Currency?
    
    private let isSaved: Bool
    
    init(navigationController: UINavigationController, currency: Currency? = nil, isSaved: Bool) {
        self.navigationController = navigationController
        self.currency = currency
        self.isSaved = isSaved
    }
    
    func start() {
        openSelectedViewController()
    }
    
    func openSelectedViewController() {
        let viewModel = SelectedViewModel(currencyManager: CurrencyManager())
        viewModel.transferredCurrency = currency
        viewModel.coordinatorDelegate = self
        let viewController = SelectedViewController(viewModel: viewModel)
        viewController.isSaved = isSaved
        viewController.hidesBottomBarWhenPushed = true
        viewController.addNavItemTitle(text: "Selected Currency", font: .montserratSemibold, fontSize: 17)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension SelectedCoordinator: SelectedCoordinatorDelegate {
    func backToPrevious(currency: Currency?) {
        self.backToPrevious?(currency)
    }
}

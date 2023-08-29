//
//  SelectedCoordinator.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 28.08.2023.
//

import UIKit

class SelectedCoordinator: Coordinator {

    weak var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    private let currency: Currency?
    
    private let isSaved: Bool
    
    var backToPrevious: ((Currency?)->Void)?
    
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
        let viewController = SelectedViewController(viewModel: viewModel)
        viewController.isSaved = isSaved
        viewController.backToPrevious = { [weak self] currency in
            self?.backToPrevious?(currency)
        }
        viewController.hidesBottomBarWhenPushed = true
        viewController.addNavItemTitle(text: "Selected Currency", font: .montserratSemibold, fontSize: 17)
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

//
//  CurrencyListCoordinator.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import UIKit

class CurrencyListCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    let navigationController: UINavigationController
    
    weak var parentCoordinator: Coordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setupPrimaryNavBar()
    }
    
    func start() {
        let viewModel = CurrencyListViewModel(networkService: CurrencyNetworkService())
        let viewController = CurrencyListViewController(viewModel: viewModel)
        viewController.addNavItemTitle(text: "Currency List", font: .montserratSemibold, fontSize: 17)
        viewController.navigationItem.backButtonTitle = ""
        navigationController.tabBarItem = UITabBarItem(title: nil,
                                                       image: TabBarItems.currencyList.image,
                                                       selectedImage: nil)
        navigationController.pushViewController(viewController, animated: true)
    }

    
    
}
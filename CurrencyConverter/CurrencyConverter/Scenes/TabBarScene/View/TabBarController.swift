//
//  TabBarController.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        self.viewControllers = [UIViewController()]
        self.viewControllers = []
        self.view.backgroundColor = .white
        UITabBar.appearance().tintColor = .lightBlue
        UITabBar.appearance().barTintColor = .white
    }
}

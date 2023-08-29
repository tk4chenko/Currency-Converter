//
//  UINavigationBar+Extension.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 24.08.2023.
//

import UIKit

extension UINavigationController {
    func setupPrimaryNavBar(largeTitleDisplayMode: UINavigationItem.LargeTitleDisplayMode = .never) {
        self.navigationBar.backIndicatorImage = UIImage(named: "back")
        self.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
        self.navigationBar.tintColor = .black
        if largeTitleDisplayMode == .never {
            self.navigationBar.prefersLargeTitles = false
        } else {
            self.navigationBar.prefersLargeTitles = true
        }
        self.navigationItem.largeTitleDisplayMode = largeTitleDisplayMode
    }
}

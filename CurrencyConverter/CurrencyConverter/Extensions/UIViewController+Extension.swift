//
//  UIViewController+Extension.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 24.08.2023.
//

import UIKit

extension UIViewController {
    func addNavItemTitle(text: String, font: CustomFonts, fontSize: Int, textColor: UIColor = UIColor.black) {
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.setCustomFont(font, fontSize: CGFloat(fontSize))
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
    }
    
    func setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

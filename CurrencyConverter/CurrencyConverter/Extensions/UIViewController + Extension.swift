//
//  UIViewController + Extension.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 24.08.2023.
//

import UIKit

extension UIViewController {
    func addNavItemTitle(text: String, font: CustomFonts, fontSize: Int, textColor: UIColor = UIColor.black) {
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.setCustomFont(font: font, fontSize: CGFloat(fontSize), textColor: textColor)
        titleLabel.sizeToFit()
        self.navigationItem.titleView = titleLabel
    }
}

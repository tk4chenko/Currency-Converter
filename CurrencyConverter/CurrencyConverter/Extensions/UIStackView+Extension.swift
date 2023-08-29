//
//  UIStackView+Extension.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import UIKit

extension UIStackView {
    
    convenience init(axis: NSLayoutConstraint.Axis, spacing: CGFloat = 5, distribution: UIStackView.Distribution = .fillEqually, alignment: UIStackView.Alignment = .fill) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.alignment = alignment
    }
    
    func addArrangedSubviews(_ arrangedSubviews: [UIView]) {
        arrangedSubviews.forEach { addArrangedSubview($0) }
    }
}

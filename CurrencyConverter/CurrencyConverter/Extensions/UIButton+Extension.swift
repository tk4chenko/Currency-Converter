//
//  UIButton+Extension.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 25.08.2023.
//

import UIKit

extension UIButton {
    convenience init(title: String? = nil, backgroundColor: UIColor? = nil, cornerRadius: CGFloat = 0, borderColor: UIColor? = nil, borderWidth: CGFloat = 0, titleColor: UIColor = .white, image: UIImage? = nil, fontSize: CGFloat = 16, fontWeight: UIFont.Weight = .regular) {
        self.init()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        self.setImage(image, for: .normal)
        self.imageView?.contentMode = .scaleAspectFit
        self.setTitleColor(titleColor, for: .normal)
        self.layer.borderColor = borderColor?.cgColor
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
    }
}

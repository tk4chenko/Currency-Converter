//
//  UITextField+Extension.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 25.08.2023.
//

import UIKit

extension UITextField {
    
    var height: CGFloat {
        return self.frame.height
    }
    
    convenience init(padding: CGFloat = 0, placeholderText: String,
                     cornerRadius: CGFloat = 0, keyboardType: UIKeyboardType = .default, backgroundColor: UIColor = .systemGray6,
                     borderColor: UIColor = .clear, fontSize: CGFloat = 16, fontWeight: UIFont.Weight = .regular, foregroundColor: UIColor = .gray, tintColor: UIColor = .gray, font: UIFont = UIFont.systemFont(ofSize: 16)){
        self.init()
        self.frame = CGRect(x: 0, y: 0, width: 300, height: 60)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = placeholderText
        self.backgroundColor = backgroundColor
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        self.tintColor = tintColor
        self.textColor = tintColor
        self.font = font
        self.layer.borderWidth = 2
        self.layer.borderColor = borderColor.cgColor
        self.layer.cornerRadius = cornerRadius
        self.keyboardType = .numberPad
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: fontSize, weight: fontWeight),
            .foregroundColor: foregroundColor
        ]
        let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        self.attributedPlaceholder = attributedPlaceholder
        self.addPadding(padding)
    }
    private func addPadding(_ amount: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: height))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    func setCustomFont(_ font: CustomFonts, fontSize: CGFloat) {
        self.font = UIFont(name: font.rawValue, size: fontSize)
    }
}

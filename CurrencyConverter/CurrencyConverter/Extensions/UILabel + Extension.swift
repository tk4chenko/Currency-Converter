//
//  UILabel + Extension.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import UIKit

enum CustomFonts: String {
    case montserratSemibold = "Montserrat-SemiBold"
    case montserratRegular = "Montserrat-Regular"
   
}

extension UILabel {
    convenience init(text: String? = nil, textColor: UIColor? = nil, textAlignment: NSTextAlignment = .center, fontSize: CGFloat = 16, fontWeight: UIFont.Weight = .regular, numberOfLines: Int = 0) {
        self.init()
        self.text = text
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = numberOfLines
        self.isUserInteractionEnabled = true
        self.textAlignment = textAlignment
        self.textColor = textColor
        self.font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
    }
    
    func setCustomFont(font: CustomFonts, fontSize: CGFloat, textColor: UIColor, alignment: NSTextAlignment = .center) {
        let attributedString = NSMutableAttributedString(string: self.text ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))

        self.font = UIFont(name: font.rawValue, size: fontSize)
        self.textColor = textColor
        self.attributedText = attributedString
    }
}

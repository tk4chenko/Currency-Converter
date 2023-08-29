//
//  UILabel+Extension.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import UIKit

enum CustomFonts: String {
    case montserratSemibold = "Montserrat-SemiBold"
    case montserratRegular = "Montserrat-Regular"
    case montserratBold = "Montserrat-Bold.ttf"
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
    
    func setCustomFont(_ font: CustomFonts, fontSize: CGFloat, alignment: NSTextAlignment = .center) {
        let attributedString = NSMutableAttributedString(string: self.text ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        
        self.font = UIFont(name: font.rawValue, size: fontSize)
        self.attributedText = attributedString
    }
    func colorTextAfterLastDot(with color: UIColor) {
        if let labelText = self.text, let dotRange = labelText.range(of: ".", options: .backwards) {
            let attributedText = NSMutableAttributedString(string: labelText)
            
            let rangeAfterDot = NSRange(dotRange.upperBound..., in: labelText)
            attributedText.addAttribute(.foregroundColor, value: color, range: rangeAfterDot)
            
            attributedText.addAttribute(.foregroundColor, value: color, range: NSRange(dotRange, in: labelText))
            
            self.attributedText = attributedText
        }
    }
    func setBoldText(boldText: String, font: CustomFonts? = nil) {
        guard let labelText = self.text else {
            return
        }
        
        let attributedText = NSMutableAttributedString(string: labelText)
        let boldFont = UIFont(name: font?.rawValue ?? "", size: self.font.pointSize) ?? UIFont.boldSystemFont(ofSize: self.font.pointSize)
        
        if let range = labelText.range(of: boldText) {
            let nsRange = NSRange(range, in: labelText)
            attributedText.addAttribute(.font, value: boldFont, range: nsRange)
        }
        
        self.attributedText = attributedText
    }
    
    func setColorToText(targetText: String, color: UIColor) {
        guard let labelText = self.text else {
            return
        }
        
        let attributedText = NSMutableAttributedString(string: labelText)
        
        if let range = labelText.range(of: targetText) {
            let nsRange = NSRange(range, in: labelText)
            attributedText.addAttribute(.foregroundColor, value: color, range: nsRange)
        }
        
        self.attributedText = attributedText
    }
    
}

//
//  SelectedCurrencyTableViewCell.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 24.08.2023.
//

import UIKit

final class SelectedCurrencyCell: UITableViewCell, IdentifiableCell {
    
    private let flagImage = UIImageView(
        contentMode: .scaleAspectFill)
    
    private let currencyCodeLabel = UILabel(
        textColor: .black,
        textAlignment: .left,
        fontSize: 14,
        fontWeight: .medium)
    
    private let currencyNameLabel = UILabel(
        textColor: .gray,
        textAlignment: .left,
        fontSize: 14)
    
    private let checkedMark = UIImageView(
        image: UIImage(named: "radio-unchecked"),
        contentMode: .scaleAspectFill)
    
    var isSelectedCell: Bool = false {
        didSet {
            checkedMark.image = isSelectedCell ? UIImage(named: "radio-checked") : UIImage(named: "radio-unchecked")
            currencyNameLabel.textColor = isSelectedCell ? .lightBlue : .black
            currencyCodeLabel.textColor = isSelectedCell ? .lightBlue : .black
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    func configureCell(_ currency: Currency, isChecked: Bool) {
        flagImage.image = UIImage(named: currency.currencyCode)
        checkedMark.image = isChecked ? UIImage(named: "radio-checked") : UIImage(named: "radio-unchecked")
        currencyCodeLabel.text = currency.currencyCode
        currencyNameLabel.text = currency.currencyName
    }
    
    private func setupConstraints() {
        self.addSubviews([flagImage, currencyCodeLabel, currencyNameLabel, checkedMark])
        
        NSLayoutConstraint.activate([
            flagImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
            flagImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            flagImage.widthAnchor.constraint(equalToConstant: 30),
            flagImage.heightAnchor.constraint(equalToConstant: 30),
            
            currencyCodeLabel.leadingAnchor.constraint(equalTo: flagImage.trailingAnchor, constant: 13),
            currencyCodeLabel.centerYAnchor.constraint(equalTo: flagImage.centerYAnchor),
            
            currencyNameLabel.leadingAnchor.constraint(equalTo: currencyCodeLabel.trailingAnchor, constant: 8),
            currencyNameLabel.centerYAnchor.constraint(equalTo: currencyCodeLabel.centerYAnchor),
            
            checkedMark.widthAnchor.constraint(equalToConstant: 32),
            checkedMark.heightAnchor.constraint(equalTo: checkedMark.widthAnchor),
            checkedMark.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            checkedMark.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

}

//
//  CurrencyListCell.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import UIKit

class CurrencyListCell: UITableViewCell, IdentifiableCell {
    
    let flagImage = UIImageView(contentMode: .scaleAspectFill)
    let currencyCodeLabel = UILabel(textColor: .black, textAlignment: .left, fontSize: 14, fontWeight: .medium)
    let currencyCountryLabel = UILabel(textColor: .lightGray, textAlignment: .left, fontSize: 14, numberOfLines: 1)
    
    let baseCodeLabel = UILabel(textAlignment: .right, fontSize: 14, fontWeight: .medium)
    let amountLabel: UILabel = {
        let label = UILabel(textAlignment: .right, fontSize: 14, fontWeight: .regular)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    func setupUI(by currency: CurrencyWithCountry) {
        
    }
    
    private func setupConstraints() {
        self.addSubviews([flagImage, currencyCodeLabel, baseCodeLabel, amountLabel, currencyCountryLabel])
        
        NSLayoutConstraint.activate([
               flagImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 17),
               flagImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
               flagImage.widthAnchor.constraint(equalToConstant: 30),
               flagImage.heightAnchor.constraint(equalToConstant: 30),
               
               currencyCodeLabel.leadingAnchor.constraint(equalTo: flagImage.trailingAnchor, constant: 13),
               currencyCodeLabel.centerYAnchor.constraint(equalTo: flagImage.centerYAnchor),
            
               amountLabel.trailingAnchor.constraint(equalTo: baseCodeLabel.leadingAnchor, constant: -4),
               amountLabel.centerYAnchor.constraint(equalTo: flagImage.centerYAnchor),
               
               baseCodeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -17),
               baseCodeLabel.centerYAnchor.constraint(equalTo: flagImage.centerYAnchor),
               
               currencyCountryLabel.leadingAnchor.constraint(equalTo: currencyCodeLabel.trailingAnchor, constant: 8),
               currencyCountryLabel.centerYAnchor.constraint(equalTo: flagImage.centerYAnchor),
               currencyCountryLabel.widthAnchor.constraint(equalToConstant: 180)
           ])
    }
    
}

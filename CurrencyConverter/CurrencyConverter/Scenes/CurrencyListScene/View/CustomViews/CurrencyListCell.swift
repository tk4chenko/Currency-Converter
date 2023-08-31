//
//  CurrencyListCell.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import UIKit

final class CurrencyListCell: UITableViewCell, IdentifiableCell {
    
    private let flagImage = UIImageView(
        contentMode: .scaleAspectFill)
    
    private let currencyCodeLabel = UILabel(
        textColor: .black,
        textAlignment: .left,
        fontSize: 14,
        fontWeight: .medium)
    
    private let currencyCountryLabel = UILabel(
        textColor: .gray,
        textAlignment: .left,
        fontSize: 14)
    
    private let baseCodeLabel = UILabel(
        textAlignment: .right,
        fontSize: 14,
        fontWeight: .medium)
    
    private let amountLabel = UILabel(
        textAlignment: .right,
        fontSize: 14,
        fontWeight: .regular)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubviews([flagImage, currencyCodeLabel, baseCodeLabel, amountLabel, currencyCountryLabel])
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    func setupUI(by currency: LatestCurrency) {
        amountLabel.text = String((100/currency.amount).roundedToTwoDecimalPlaces())
        amountLabel.colorTextAfterLastDot(with: .gray)
        flagImage.image = UIImage(named: currency.currencyCode)
        currencyCodeLabel.text = currency.currencyCode
        baseCodeLabel.text = currency.baseCode
        currencyCountryLabel.text = currency.currencyCountry
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            flagImage.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 17),
            flagImage.centerYAnchor.constraint(
                equalTo: self.centerYAnchor),
            flagImage.widthAnchor.constraint(
                equalToConstant: 30),
            flagImage.heightAnchor.constraint(
                equalToConstant: 30),
            
            currencyCodeLabel.leadingAnchor.constraint(
                equalTo: flagImage.trailingAnchor,
                constant: 13),
            currencyCodeLabel.centerYAnchor.constraint(
                equalTo: flagImage.centerYAnchor),
            
            amountLabel.trailingAnchor.constraint(
                equalTo: baseCodeLabel.leadingAnchor,
                constant: -4),
            amountLabel.centerYAnchor.constraint(
                equalTo: flagImage.centerYAnchor),
            
            baseCodeLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -17),
            baseCodeLabel.centerYAnchor.constraint(
                equalTo: flagImage.centerYAnchor),
            
            currencyCountryLabel.leadingAnchor.constraint(
                equalTo: currencyCodeLabel.trailingAnchor,
                constant: 8),
            currencyCountryLabel.centerYAnchor.constraint(
                equalTo: flagImage.centerYAnchor),
            currencyCountryLabel.widthAnchor.constraint(
                equalToConstant: 180)
        ])
    }
}

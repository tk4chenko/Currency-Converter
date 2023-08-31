//
//  WalletCell.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 25.08.2023.
//

import UIKit

class WalletCell: UITableViewCell, IdentifiableCell {
    
    private let flagImage = UIImageView(
        contentMode: .scaleAspectFill)
    
    private let currencyCodeLabel = UILabel(
        textColor: .black,
        textAlignment: .left,
        fontSize: 20,
        fontWeight: .medium)
    
    private let amountInDollarsLabel = UILabel(
        textColor: .gray,
        textAlignment: .right,
        fontSize: 16,
        fontWeight: .medium)
    
    private let amountLabel = UILabel(
        textAlignment: .right,
        fontSize: 20,
        fontWeight: .medium)
    
    private let stackView = UIStackView(
        axis: .vertical,
        spacing: 3,
        distribution: .fill)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    func setupCell(with wallet: Wallet) {
        flagImage.image = UIImage(named: wallet.code)
        currencyCodeLabel.text = wallet.code
        let currencySymbol = wallet.code.getSymbolForCurrencyCode()
        amountLabel.text = "\(currencySymbol)\(wallet.amount.roundedToTwoDecimalPlaces())"
        amountLabel.colorTextAfterLastDot(with: .gray)
        amountInDollarsLabel.text = "$\(wallet.usdAmmount.roundedToTwoDecimalPlaces())"
        amountInDollarsLabel.colorTextAfterLastDot(with: .lightGray)
    }
    
    private func setupConstraints() {
        stackView.addArrangedSubviews([currencyCodeLabel, amountInDollarsLabel])
        contentView.addSubviews([flagImage, stackView, amountLabel])
        NSLayoutConstraint.activate([
            flagImage.widthAnchor.constraint(
                equalToConstant: 60),
            flagImage.heightAnchor.constraint(
                equalToConstant: 60),
            flagImage.centerYAnchor.constraint(
                equalTo: self.centerYAnchor),
            flagImage.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 17),
            
            stackView.centerYAnchor.constraint(
                equalTo: self.centerYAnchor),
            stackView.leadingAnchor.constraint(
                equalTo: flagImage.trailingAnchor,
                constant: 18),
            
            amountLabel.centerYAnchor.constraint(
                equalTo: self.centerYAnchor),
            amountLabel.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -17)
        ])
    }
}

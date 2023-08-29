//
//  WallerHeader.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 25.08.2023.
//

import UIKit

class WalletHeader: UITableViewHeaderFooterView, IdentifiableCell {
    
    private let titleLabel = UILabel(text: "Total Balance", textColor: .gray, textAlignment: .left, fontSize: 20, fontWeight: .semibold)
    
    let totalBalanceLabel = UILabel(text: "$ 2.445.21", textColor: .black, textAlignment: .left, fontSize: 48, fontWeight: .semibold)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
        totalBalanceLabel.colorTextAfterLastDot(with: .gray)
    }
    
    private func setupConstraints() {
        contentView.addSubviews([titleLabel, totalBalanceLabel])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 13),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 23),
            
            totalBalanceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -11),
            totalBalanceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
    }
}

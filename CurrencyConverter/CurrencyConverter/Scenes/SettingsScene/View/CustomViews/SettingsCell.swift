//
//  SelectedCurrencyView.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import UIKit

final class SettingsCell: UITableViewCell, IdentifiableCell {
    
    private let flagImage = UIImageView(
        image: UIImage(named: "UAH"),
        contentMode: .scaleAspectFill)
    
    private let titleLabel = UILabel(
        text: "Selected Currency:",
        textColor: .lightGray,
        textAlignment: .left,
        fontSize: 14)
    
    private let countryNameLabel = UILabel(
        text: "Ukraine",
        textColor: .black,
        textAlignment: .left,
        fontSize: 14,
        fontWeight: .medium)
    
    private let stackView = UIStackView(
        axis: .vertical,
        spacing: 8,
        distribution: .fill)

    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    func configureCell(_ currency: Currency) {
        flagImage.image = UIImage(named: currency.currencyCode)
        countryNameLabel.text = currency.currencyCountry
    }

    private func setupConstraints() {
        stackView.addArrangedSubviews([titleLabel, countryNameLabel])
        self.addSubview(stackView)
        self.addSubview(flagImage)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            flagImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            flagImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -18),
            flagImage.widthAnchor.constraint(equalToConstant: 44),
            flagImage.heightAnchor.constraint(equalTo: flagImage.widthAnchor)
        ])
    }
}

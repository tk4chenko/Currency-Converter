//
//  SelectCountryCurrencyView.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 25.08.2023.
//

import UIKit

final class SelectCountryCurrencyView: UIView {
    
    var currency: Currency?
    
    private let flagImage = UIImageView(
        image: UIImage(named: "default"),
        contentMode: .scaleAspectFill)
    
    private let currencyNameLabel = UILabel(
        text: "--",
        textColor: .gray,
        textAlignment: .left)
    
    private let currencyCountryLabel = UILabel(
        text: "No Country Selected",
        textColor: .black,
        textAlignment: .left,
        numberOfLines: 1)
    
    private let stackView = UIStackView(
        axis: .vertical,
        spacing: 3,
        distribution: .fill,
        alignment: .leading)
    
    private let chevronImageView = UIImageView(
        image: UIImage(named: "chevron"),
        contentMode: .scaleToFill)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    func setupView(_ currency: Currency?) {
        guard let currency else { return }
        self.currency = currency
        flagImage.image = UIImage(named: currency.currencyCode)
        currencyNameLabel.text = "\(currency.currencyName) (\(currency.currencyCode))"
        currencyCountryLabel.text = currency.currencyCountry
        currencyNameLabel.setCustomFont(.montserratRegular, fontSize: 17)
        currencyCountryLabel.setCustomFont(.montserratSemibold, fontSize: 17)
        currencyNameLabel.setBoldText(boldText: currency.currencyCode, font: .montserratBold)
    }
    
    private func commonInit() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 16
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 2
        currencyNameLabel.setCustomFont(.montserratRegular, fontSize: 17)
        currencyCountryLabel.setCustomFont(.montserratSemibold, fontSize: 17)
        self.isUserInteractionEnabled = true
        stackView.addArrangedSubviews([currencyCountryLabel, currencyNameLabel])
        self.addSubviews([flagImage, stackView, chevronImageView])
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            flagImage.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 22),
            flagImage.centerYAnchor.constraint(
                equalTo: self.centerYAnchor),
            flagImage.heightAnchor.constraint(
                equalToConstant: 44),
            flagImage.widthAnchor.constraint(
                equalToConstant: 44),
            
            stackView.centerYAnchor.constraint(
                equalTo: self.centerYAnchor),
            stackView.leadingAnchor.constraint(
                equalTo: flagImage.trailingAnchor, constant: 19),
            stackView.trailingAnchor.constraint(
                equalTo: chevronImageView.leadingAnchor,
                constant: -19),
            
            chevronImageView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -24),
            chevronImageView.centerYAnchor.constraint(
                equalTo: self.centerYAnchor)
        ])
    }
}

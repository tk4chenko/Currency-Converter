//
//  BidsItemCell.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 28.08.2023.
//

import UIKit

class BidsItemCell: UITableViewCell, IdentifiableCell {
    
    private let fromFlagImagView = UIImageView(
        image: UIImage(named: "default"),
        contentMode: .scaleAspectFill)
    
    private let toFlagImageView = UIImageView(
        image: UIImage(named: "default"),
        contentMode: .scaleAspectFill)
    
    private let arrowImageView = UIImageView(
        image: UIImage(named: "arrow"),
        contentMode: .scaleAspectFit)
    
    private let currencyCodeLabel = UILabel(
        textColor: .black,
        textAlignment: .left,
        fontSize: 15,
        fontWeight: .medium)
    
    private let fromAmountLabel = UILabel(
        textAlignment: .right,
        fontSize: 20,
        fontWeight: .semibold)
    
    private let toAmountLabel = UILabel(
        textAlignment: .right,
        fontSize: 20,
        fontWeight: .semibold)
    
    private let imagesStackView = UIStackView(
        axis: .horizontal,
        spacing: -11,
        distribution: .fill)
    
    private let amountsStackView = UIStackView(
        axis: .horizontal,
        spacing: 70,
        distribution: .equalCentering)
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Open", for: .normal)
        button.setTitle("Closed", for: .selected)
        button.setTitleColor(.green, for: .normal)
        button.setTitleColor(.gray, for: .selected)
        button.backgroundColor = button.isSelected ? .ultraLightGray : .lightGreen
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc private func buttonPressed(_ sender: UIButton) {
        sender.isSelected.toggle()
        sender.backgroundColor = sender.isSelected ? .ultraLightGray : .lightGreen
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    func setupCell(with bid: Bid) {
        fromFlagImagView.image = UIImage(named: bid.fromCode)
        toFlagImageView.image = UIImage(named: bid.toCode)
        currencyCodeLabel.text = "\(bid.fromCode) / \(bid.toCode)"
        currencyCodeLabel.setColorToText(targetText: "/", color: .gray)
        fromAmountLabel.text = String(bid.fromAmount.roundedToTwoDecimalPlaces())
        toAmountLabel.text = String(bid.toAmount.roundedToTwoDecimalPlaces())
        fromAmountLabel.colorTextAfterLastDot(with: .gray)
        toAmountLabel.colorTextAfterLastDot(with: .gray)
    }
    
    private func setupConstraints() {
        amountsStackView.addArrangedSubviews([fromAmountLabel, arrowImageView, toAmountLabel])
        imagesStackView.addArrangedSubviews([fromFlagImagView, toFlagImageView])
        self.addSubviews([button, imagesStackView, currencyCodeLabel, amountsStackView])
        
        NSLayoutConstraint.activate([
            imagesStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            imagesStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
            
            button.topAnchor.constraint(equalTo: self.topAnchor, constant: 19),
            button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -19),
            button.widthAnchor.constraint(equalToConstant: 70),
            button.heightAnchor.constraint(equalToConstant: 32),
            
            currencyCodeLabel.topAnchor.constraint(equalTo: imagesStackView.bottomAnchor, constant: 21),
            currencyCodeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            arrowImageView.widthAnchor.constraint(equalToConstant: 35),
            
            amountsStackView.topAnchor.constraint(equalTo: currencyCodeLabel.bottomAnchor, constant: 11),
            amountsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            amountsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
        for view in imagesStackView.arrangedSubviews {
            view.widthAnchor.constraint(equalToConstant: 34).isActive = true
            view.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        }
    }
    
}

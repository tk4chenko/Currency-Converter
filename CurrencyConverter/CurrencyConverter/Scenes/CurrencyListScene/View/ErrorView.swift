//
//  ErrorView.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 24.08.2023.
//

import UIKit

class ErrorView: UIView {

    private let errorImage = UIImageView(image: UIImage(named: "error"), contentMode: .scaleToFill)
    
    private let errorLabel: UILabel = {
        let label = UILabel(text: "Something went wrong while fetching data. Please, try again", textColor: .black)
        label.setCustomFont(font: .montserratRegular, fontSize: 20, textColor: .black)
        return label
    }()
    
    let retryButton: UIButton = {
        let button = UIButton()
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .lightGreen
        $0.tintColor = .white
        $0.setTitle("Retry", for: .normal)
        $0.titleLabel?.setCustomFont(font: .montserratSemibold, fontSize: 15, textColor: .black)
        $0.layer.cornerRadius = 8
        return $0
    }(UIButton())
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    private func setupConstraints() {
        self.addSubviews([errorImage, errorLabel, retryButton])
        NSLayoutConstraint.activate([
            errorImage.topAnchor.constraint(equalTo: self.topAnchor),
            errorImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            errorImage.widthAnchor.constraint(equalToConstant: 80),
            errorImage.heightAnchor.constraint(equalToConstant: 75),
            
            errorLabel.topAnchor.constraint(equalTo: errorImage.bottomAnchor, constant: 24),
            errorLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            errorLabel.widthAnchor.constraint(equalToConstant: 294),
            errorLabel.heightAnchor.constraint(equalToConstant: 75),
            
            retryButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 37),
            retryButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            retryButton.widthAnchor.constraint(equalToConstant: 207),
            retryButton.heightAnchor.constraint(equalToConstant: 42)
        ])
    }

}

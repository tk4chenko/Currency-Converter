//
//  ErrorView.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 24.08.2023.
//

import UIKit

final class ErrorView: UIView {
    
    private let errorImage = UIImageView(
        image: UIImage(named: "error"),
        contentMode: .scaleToFill)
    
    private let errorLabel = UILabel(
        text: "Something went wrong while fetching data. Please, try again",
        textColor: .black)
    
    let retryButton  = UIButton(
        title: "Retry",
        backgroundColor: .green,
        cornerRadius: 8,
        titleColor: .white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubviews([errorImage, errorLabel, retryButton])
        errorLabel.setCustomFont(.montserratRegular, fontSize: 20)
        retryButton.titleLabel?.setCustomFont(.montserratSemibold, fontSize: 15)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            errorImage.topAnchor.constraint(
                equalTo: self.topAnchor),
            errorImage.centerXAnchor.constraint(
                equalTo: self.centerXAnchor),
            errorImage.widthAnchor.constraint(
                equalToConstant: 80),
            errorImage.heightAnchor.constraint(
                equalToConstant: 75),
            
            errorLabel.topAnchor.constraint(
                equalTo: errorImage.bottomAnchor,
                constant: 24),
            errorLabel.centerXAnchor.constraint(
                equalTo: self.centerXAnchor),
            errorLabel.widthAnchor.constraint(
                equalToConstant: 294),
            errorLabel.heightAnchor.constraint(
                equalToConstant: 75),
            
            retryButton.topAnchor.constraint(
                equalTo: errorLabel.bottomAnchor,
                constant: 37),
            retryButton.centerXAnchor.constraint(
                equalTo: self.centerXAnchor),
            retryButton.widthAnchor.constraint(
                equalToConstant: 207),
            retryButton.heightAnchor.constraint(
                equalToConstant: 42)
        ])
    }
}

//
//  AddOwnedCurrencyViewController.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 25.08.2023.
//

import UIKit

final class AddOwnedCurrencyViewController: UIViewController {
    
    var openSelectedCurrencyController: ((Currency?)->Void)?
    
    var currency: Currency? {
        didSet {
            selectCountryCurrencyView.setupView(currency)
            isEnabled()
        }
    }
    
    private let ownedValueLabel = UILabel(
        text: "Owned Value",
        textColor: .black,
        textAlignment: .left,
        fontSize: 17)
    
    private let ownedValueTextField = UITextField(
        padding: 12,
        placeholderText: "Enter Owned Currency Value",
        cornerRadius: 8,
        keyboardType: .numberPad,
        backgroundColor: .clear,
        borderColor: .lightGray,
        fontSize: 15,
        foregroundColor: .lightGray,
        tintColor: .lightBlue)
    
    private let selectCountryLabel = UILabel(
        text: "Select Country Currency",
        textColor: .black,
        textAlignment: .left,
        fontSize: 17)
    
    private let addButton = UIButton(
        title: "Add",
        backgroundColor: .lightGray,
        cornerRadius: 8,
        titleColor: .white)
    
    private let selectCountryCurrencyView = SelectCountryCurrencyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setupDismissKeyboardGesture()
        ownedValueLabel.setCustomFont(.montserratSemibold, fontSize: 17)
        selectCountryLabel.setCustomFont(.montserratSemibold, fontSize: 17)
        addButton.titleLabel?.setCustomFont(.montserratSemibold, fontSize: 15)
        ownedValueTextField.setCustomFont(.montserratRegular, fontSize: 15)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectCountryCurrencyPressed))
        selectCountryCurrencyView.addGestureRecognizer(tapGesture)
        selectCountryCurrencyView.isUserInteractionEnabled = true
        ownedValueTextField.delegate = self
        addButton.isEnabled = false
    }

    @objc private func selectCountryCurrencyPressed() {
        openSelectedCurrencyController?(currency)
    }
    
    private func isEnabled() {
        guard let text = ownedValueTextField.text else { return }
        if !text.isEmpty && currency != nil {
            addButton.isEnabled = true
            addButton.backgroundColor = .darkBlue
        } else {
            addButton.isEnabled = false
            addButton.backgroundColor = .lightGray
        }
    }
    
    private func setupConstraints() {
        view.addSubviews([ownedValueLabel, ownedValueTextField, selectCountryLabel, addButton, selectCountryCurrencyView])
        
        NSLayoutConstraint.activate([
            ownedValueLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            ownedValueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            ownedValueTextField.topAnchor.constraint(equalTo: ownedValueLabel.bottomAnchor, constant: 9),
            ownedValueTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ownedValueTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ownedValueTextField.heightAnchor.constraint(equalToConstant: 40),
            
            selectCountryLabel.topAnchor.constraint(equalTo: ownedValueTextField.bottomAnchor, constant: 18),
            selectCountryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            selectCountryCurrencyView.topAnchor.constraint(equalTo: selectCountryLabel.bottomAnchor, constant: 9),
            selectCountryCurrencyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            selectCountryCurrencyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            selectCountryCurrencyView.heightAnchor.constraint(equalToConstant: 87),
            
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -22),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 42)
        ])
    }

}

extension AddOwnedCurrencyViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        isEnabled()
    }
}

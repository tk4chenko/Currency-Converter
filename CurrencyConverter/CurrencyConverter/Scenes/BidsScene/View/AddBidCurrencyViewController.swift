//
//  AddBidCurrencyViewController.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 28.08.2023.
//

import UIKit

enum Direction {
    case from, to
}

class AddBidCurrencyViewController: UIViewController {
    
    var openSelectedCurrencyController: ((Currency?)->Void)?
    
    private let viewModel: AddBidCurrencyViewModel
    
    var direction: Direction?
    
    var currency: (Currency?, Currency?) {
        didSet {
            isEnabled()
            fromSelectCountryCurrencyView.setupView(currency.0)
            toSelectCountryCurrencyView.setupView(currency.1)
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
    
    private let fromSelectCountryLabel = UILabel(
        text: "Select Country Currency (From)",
        textColor: .black,
        textAlignment: .left,
        fontSize: 17)
    
    private let toSelectCountryLabel = UILabel(
        text: "Select Country Currency (To)",
        textColor: .black,
        textAlignment: .left,
        fontSize: 17)
    
    private let addButton = UIButton(
        title: "Add",
        backgroundColor: .lightGray,
        cornerRadius: 8,
        titleColor: .white)
    
    private let fromSelectCountryCurrencyView = SelectCountryCurrencyView()
    
    private let toSelectCountryCurrencyView = SelectCountryCurrencyView()
    
    init(viewModel: AddBidCurrencyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        fromSelectCountryLabel.setCustomFont(.montserratSemibold, fontSize: 17)
        toSelectCountryLabel.setCustomFont(.montserratSemibold, fontSize: 17)
        addButton.titleLabel?.setCustomFont(.montserratSemibold, fontSize: 15)
        ownedValueTextField.setCustomFont(.montserratRegular, fontSize: 15)
        ownedValueTextField.delegate = self
        fromSelectCountryCurrencyView.tag = 0
        toSelectCountryCurrencyView.tag = 1
        let fromTapGesture = UITapGestureRecognizer(target: self, action: #selector(selectCountryCurrencyPressed))
        let toTapGesture = UITapGestureRecognizer(target: self, action: #selector(selectCountryCurrencyPressed))
        fromSelectCountryCurrencyView.addGestureRecognizer(fromTapGesture)
        toSelectCountryCurrencyView.addGestureRecognizer(toTapGesture)
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
    }
    
    private func isEnabled() {
        guard let text = ownedValueTextField.text else { return }
        if !text.isEmpty && currency.0 != nil && currency.1 != nil {
            addButton.isEnabled = true
            addButton.backgroundColor = .darkBlue
        } else {
            addButton.isEnabled = false
            addButton.backgroundColor = .lightGray
        }
    }
    
    @objc private func addButtonPressed() {
        print("Pressed")
        let bid = Bid(fromCode: "EUR", toCode: "USD", fromAmount: 100, toAmmount: 200)
        viewModel.saveBid(bid)
    }
    
    @objc private func selectCountryCurrencyPressed(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view as? SelectCountryCurrencyView else { return }
        switch view.tag {
        case 0:
            direction = .from
            openSelectedCurrencyController?(currency.0)
        case 1:
            direction = .to
            openSelectedCurrencyController?(currency.1)
        default:
            return
        }
        
    }
    
    private func setupConstraints() {
        view.addSubviews([ownedValueLabel, ownedValueTextField, fromSelectCountryLabel, addButton, fromSelectCountryCurrencyView, toSelectCountryLabel, toSelectCountryCurrencyView])
        
        NSLayoutConstraint.activate([
            ownedValueLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            ownedValueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            ownedValueTextField.topAnchor.constraint(equalTo: ownedValueLabel.bottomAnchor, constant: 9),
            ownedValueTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ownedValueTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ownedValueTextField.heightAnchor.constraint(equalToConstant: 40),
            
            fromSelectCountryLabel.topAnchor.constraint(equalTo: ownedValueTextField.bottomAnchor, constant: 18),
            fromSelectCountryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            fromSelectCountryCurrencyView.topAnchor.constraint(equalTo: fromSelectCountryLabel.bottomAnchor, constant: 9),
            fromSelectCountryCurrencyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fromSelectCountryCurrencyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            fromSelectCountryCurrencyView.heightAnchor.constraint(equalToConstant: 87),
            
            toSelectCountryLabel.topAnchor.constraint(equalTo: fromSelectCountryCurrencyView.bottomAnchor, constant: 18),
            toSelectCountryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            toSelectCountryCurrencyView.topAnchor.constraint(equalTo: toSelectCountryLabel.bottomAnchor, constant: 9),
            toSelectCountryCurrencyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            toSelectCountryCurrencyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            toSelectCountryCurrencyView.heightAnchor.constraint(equalToConstant: 87),
            
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -22),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 42),
        ])
    }
}

extension AddBidCurrencyViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        isEnabled()
    }
}

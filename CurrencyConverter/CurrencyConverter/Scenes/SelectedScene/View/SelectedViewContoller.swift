//
//  SelectedViewController.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 29.08.2023.
//

import UIKit

class SelectedViewController: UIViewController {
    
    var backToPrevious: ((Currency?) -> Void)?
    
    var isSaved: Bool = false
    
    var viewModel: SelectedViewModelProtocol
    
    private lazy var tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.rowHeight = 60
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.dataSource = self
        $0.register(SelectedCurrencyCell.self, forCellReuseIdentifier: SelectedCurrencyCell.identifier)
        return $0
    }(UITableView())
    
    init(viewModel: SelectedViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    
}

extension SelectedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currencyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectedCurrencyCell.identifier, for: indexPath) as! SelectedCurrencyCell
        cell.selectionStyle = .none
        let currency = viewModel.currencyList[indexPath.row]
        var isChecked: Bool
        if isSaved {
            isChecked = currency.currencyCode == viewModel.storedCurrency?.currencyCode
        } else {
            isChecked = currency.currencyCode == viewModel.transferredCurrency?.currencyCode
        }
        cell.configureCell(currency, isChecked: isChecked)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isSaved {
            let currencyCpde = viewModel.currencyList[indexPath.row].currencyCode
            viewModel.saveCurrency(currencyCpde)
            viewModel.backToPrevious(with: nil)
        } else {
            let currency = viewModel.currencyList[indexPath.row]
            viewModel.backToPrevious(with: currency)
        }
    }
}

//
//  WalletViewController.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 25.08.2023.
//

import UIKit

class WalletViewController: UIViewController {
    
    private var viewModel: WalletViewModelProtocol
    
    private lazy var tableView: UITableView = {
        $0.isHidden = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.dataSource = self
        $0.delegate = self
        $0.sectionHeaderTopPadding = 0
        $0.register(WalletCell.self, forCellReuseIdentifier: WalletCell.identifier)
        $0.register(WalletHeader.self, forHeaderFooterViewReuseIdentifier: WalletHeader.identifier)
        return $0
    }(UITableView())
    
    private let loadingIndicator: UIActivityIndicatorView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.style = .medium
        $0.color = .gray
        $0.startAnimating()
        return $0
    }(UIActivityIndicatorView())
    
    private lazy var searchController: UISearchController = {
        $0.searchResultsUpdater = self
        $0.obscuresBackgroundDuringPresentation = false
        $0.searchBar.placeholder = "Search Currency"
        return $0
    }(UISearchController())
    
    init(viewModel: WalletViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindigs()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }
    
    private func setupUI() {
        let firstButton = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(addPressed))
        let secondButton = UIBarButtonItem(image: UIImage(named: "magnifyingglass"), style: .plain, target: self, action: #selector(searchPressed))
        navigationItem.rightBarButtonItems = [firstButton, secondButton]
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        view.addSubviews([tableView, loadingIndicator])
    }
    
    @objc private func searchPressed() {
        searchController.searchBar.becomeFirstResponder()
    }
    
    @objc private func addPressed() {
        viewModel.openAddOwnedCurrencyController()
    }
    
    private func setupBindigs() {
        viewModel.wallets.bind { bids in
            if bids != nil {
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor),
            
            loadingIndicator.centerYAnchor.constraint(
                equalTo: view.centerYAnchor),
            loadingIndicator.centerXAnchor.constraint(
                equalTo: view.centerXAnchor)
        ])
    }
}

extension WalletViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WalletCell.identifier) as? WalletCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        let wallet = viewModel.filteredCurrencies[indexPath.row]
        cell.setupCell(with: wallet)
        return cell
    }
}

extension WalletViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        124
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        109
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: WalletHeader.identifier ) as? WalletHeader else { return nil}
        headerView.totalBalanceLabel.text = "$ \(viewModel.totalBalance)"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            
            let wallet = self.viewModel.filteredCurrencies[indexPath.row]
            self.viewModel.deleteWallet(wallet)
            self.viewModel.loadData()
        }
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

extension WalletViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchQuery = searchController.searchBar.text?.lowercased() else {
            return
        }
    
        if searchQuery.isEmpty {
            viewModel.filteredCurrencies = viewModel.wallets.value ?? []
        } else {
            viewModel.filteredCurrencies = viewModel.wallets.value?.filter { currency in
                return currency.code.lowercased().contains(searchQuery)
            } ?? []
        }
        tableView.reloadData()
    }

}

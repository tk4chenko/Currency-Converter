//
//  WalletViewController.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 25.08.2023.
//

import UIKit

class WalletViewController: UIViewController {
    
    var openAddOwnedCurrencyController: (()->Void)?
    
    private let viewModel: WalletViewModel
    
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
        //        $0.startAnimating()
        return $0
    }(UIActivityIndicatorView())
    
    private lazy var searchController: UISearchController = {
        $0.searchResultsUpdater = self
        $0.obscuresBackgroundDuringPresentation = false
        $0.searchBar.placeholder = "Search Currency"
        return $0
    }(UISearchController())
    
    init(viewModel: WalletViewModel) {
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
        let firstButton = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(addPressed))
        let secondButton = UIBarButtonItem(image: UIImage(named: "magnifyingglass"), style: .plain, target: self, action: #selector(searchPressed))
        navigationItem.rightBarButtonItems = [firstButton, secondButton]
        //        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    @objc private func searchPressed() {
        
    }
    
    @objc private func addPressed() {
        openAddOwnedCurrencyController?()
    }
    
    private func setupConstraints() {
        view.addSubviews([tableView, loadingIndicator])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadingIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension WalletViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WalletCell.identifier) as? WalletCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.setupCell(with: Wallet(code: "USD", amount: 100, usdAmmount: 200))
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
        return headerView
    }
}

extension WalletViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}


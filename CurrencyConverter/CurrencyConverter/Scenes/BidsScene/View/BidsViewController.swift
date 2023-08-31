//
//  BidsViewController.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 25.08.2023.
//

import UIKit

final class BidsViewController: UIViewController {
    
    private var viewModel: BidsViewModelProtocol
    
    private lazy var tableView: UITableView = {
        $0.isHidden = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.rowHeight = 146
        $0.backgroundColor = .clear
        $0.dataSource = self
        $0.delegate = self
        $0.register(BidsItemCell.self, forCellReuseIdentifier: BidsItemCell.identifier)
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
    
    init(viewModel: BidsViewModelProtocol) {
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
    
    private func setupBindigs() {
        viewModel.bids.bind { bids in
            if bids != nil {
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @objc private func searchPressed() {
        searchController.searchBar.becomeFirstResponder()
    }
    
    @objc private func addPressed() {
        viewModel.openAddBidCurrencyController()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerYAnchor.constraint(
                equalTo: view.centerYAnchor),
            loadingIndicator.centerXAnchor.constraint(
                equalTo: view.centerXAnchor)
        ])
    }
}

extension BidsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredBids.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BidsItemCell.identifier) as? BidsItemCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        let bid = viewModel.filteredBids[indexPath.row]
        cell.setupCell(with: bid)
        return cell
    }
}

extension BidsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            let bid = self.viewModel.filteredBids[indexPath.row]
            self.viewModel.deleteBid(bid)
            self.viewModel.loadData()
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}

extension BidsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchQuery = searchController.searchBar.text?.lowercased() else {
            return
        }
        if searchQuery.isEmpty {
            viewModel.filteredBids = viewModel.bids.value ?? []
        } else {
            viewModel.filteredBids = viewModel.bids.value?.filter { currency in
                currency.fromCode.lowercased().contains(searchQuery) || currency.toCode.lowercased().contains(searchQuery)
            } ?? []
        }
        tableView.reloadData()
    }
}

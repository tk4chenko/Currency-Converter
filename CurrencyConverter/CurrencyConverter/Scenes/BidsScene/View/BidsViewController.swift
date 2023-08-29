//
//  BidsViewController.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 25.08.2023.
//

import UIKit

class BidsViewController: UIViewController {
    
    private let viewModel: BidsViewModel
    
    var openAddBidCurrencyController: (()->Void)?
    
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
    
    init(viewModel: BidsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
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
//        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func setupBindigs() {
        viewModel.bids.bind { bids in
            if bids != nil {
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.removeFromSuperview()
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @objc private func searchPressed() {
        
    }
    
    @objc private func addPressed() {
        openAddBidCurrencyController?()
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

extension BidsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.bids.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BidsItemCell.identifier) as? BidsItemCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        if let bid = viewModel.bids.value?[indexPath.row] {
            cell.setupCell(with: bid)
        }
        return cell
    }
    

}

extension BidsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            
            guard let bid = self.viewModel.bids.value?[indexPath.row] else { return }
            self.viewModel.deleteBid(bid)
                tableView.reloadData()
            }
        
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
    }
}

extension BidsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}


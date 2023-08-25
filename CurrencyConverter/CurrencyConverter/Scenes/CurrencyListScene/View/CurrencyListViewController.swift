//
//  CurrencyListViewController.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import UIKit

class CurrencyListViewController: UIViewController {
    
    
    let array = [""]
    
    private let viewModel: CurrencyListViewModel
    
    private lazy var tableView: UITableView = {
        $0.isHidden = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.rowHeight = 60
        $0.backgroundColor = .clear
        $0.dataSource = self
        $0.register(CurrencyListCell.self, forCellReuseIdentifier: CurrencyListCell.identifier)
        return $0
    }(UITableView())
    
    private let loadingIndicator: UIActivityIndicatorView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.style = .medium
        $0.color = .gray
        $0.startAnimating()
        return $0
    }(UIActivityIndicatorView())
    
    private let errorView: ErrorView = {
        $0.isHidden = true
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(ErrorView())
    
    private lazy var searchController: UISearchController = {
        $0.searchResultsUpdater = self
        $0.obscuresBackgroundDuringPresentation = false
        $0.searchBar.placeholder = "Search Currency"
        return $0
    }(UISearchController())
    
    init(viewModel: CurrencyListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await viewModel.loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }
    
    private func setupUI() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "magnifyingglass"), style: .plain, target: self, action: #selector(searchPressed))
        setupBindings()
        errorView.retryButton.addTarget(self, action: #selector(retryPressed), for: .touchUpInside)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func setupBindings() {
        viewModel.currencyList.bind { [weak self] result in
            guard let self else { return }
            if result != nil {
                DispatchQueue.main.async {                    self.errorView.isHidden = true
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.removeFromSuperview()
                    self.tableView.reloadData()
                }
            }
        }
        
        viewModel.error.bind { [weak self] result in
            guard let self else { return }
            if result != nil {
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.loadingIndicator.removeFromSuperview()
                    self.errorView.isHidden = false
                }
            }
        }
    }
    
    private func setupConstraints() {
        view.addSubviews([tableView, errorView, loadingIndicator])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadingIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loadingIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            errorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 183),
            errorView.widthAnchor.constraint(equalTo: view.widthAnchor),
            errorView.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    @objc private func retryPressed() {
        Task {
            await viewModel.loadData()
        }
    }
    
    @objc private func searchPressed() {
        
    }
    
}

extension CurrencyListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.currencyList.value?.conversionRates?.keys.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyListCell.identifier) as? CurrencyListCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        guard let currencyList = viewModel.currencyList.value,
              let conversionRates = currencyList.conversionRates else {
            return UITableViewCell() }
        let sortedKeys = conversionRates.keys.sorted(by: <)
        let currencyCode = sortedKeys[indexPath.row]
        
        if let currencyAmount = conversionRates[currencyCode] {
            let labelText = String(describing: currencyAmount)
            let attributedText = NSMutableAttributedString(string: labelText)
            if let dotRange = labelText.range(of: ".") {
                let grayColor = UIColor.gray
                let rangeAfterDot = NSRange(dotRange.upperBound..., in: labelText)
                attributedText.addAttribute(.foregroundColor, value: grayColor, range: rangeAfterDot)
            }
            cell.amountLabel.attributedText = attributedText
        }
        cell.flagImage.image = UIImage(named: currencyCode)
        cell.currencyCodeLabel.text = currencyCode
        cell.baseCodeLabel.text = currencyList.baseCode
        cell.currencyCountryLabel.text = CurrencyManager.currencyList.first(where: { $0.currencyCode == currencyCode })?.currencyCountry
        return cell
    }
}

extension CurrencyListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

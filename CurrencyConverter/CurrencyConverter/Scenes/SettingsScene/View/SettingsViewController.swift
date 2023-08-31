//
//  SettingsViewController.swift
//  CurrencyConverter
//
//  Created by Artem Tkachenko on 23.08.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    private let viewModel: SettingsViewModelProtocol

    init(viewModel: SettingsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.rowHeight = 86
        $0.backgroundColor = .clear
        $0.delegate = self
        $0.dataSource = self
        $0.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.identifier)
        return $0
    }(UITableView())
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.identifier) as? SettingsCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        guard let selectedCurrency = viewModel.selectedCurrency else { return UITableViewCell() }
        cell.configureCell(selectedCurrency)
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.openSelectedCurrencyController()
    }
}

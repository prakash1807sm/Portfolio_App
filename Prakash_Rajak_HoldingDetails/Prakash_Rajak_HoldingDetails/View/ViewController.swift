//
//  ViewController.swift
//  Prakash_Rajak_HoldingDetails
//
//  Created by Prakash Rajak on 24/12/25.
//

import UIKit


class ViewController: UIViewController {

    private let topBarView = TopBarView()
    private let portfolioTypeView = PortfolioSegmentView()
    private let tableView = UITableView()
    private let summaryView = PortfolioSummaryView()
    private let model: ViewModel = ViewModel(responseFetchCase: FetchHoldingResponseForApi(apiManager: ApiManager()))
    
    private let expandedProfileSummaryView = ExpandedPortfolioSummaryView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addStatusBarColor()
        setTopBarView()
        addPortfolioTypeView()
        setupUI()
        setupStateChangeCallback()
        setupToggleCallback()
        model.fetchHoldings()
    }
    
    func setTopBarView() {
        view.addSubview(topBarView)
        
        topBarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBarView.heightAnchor.constraint(equalToConstant: 56)
            ])
    }
    
    func setBottomSuperArea() {
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.colorWithHexString(hex: "#F5F5F5")
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupUI() {
        addSummaryView()
        addTableView()
        addExpandedProfileSummaryView()
    }
    
    
    func addPortfolioTypeView() {
        view.addSubview(portfolioTypeView)
        
        portfolioTypeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            portfolioTypeView.topAnchor.constraint(equalTo: topBarView.bottomAnchor),
            portfolioTypeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            portfolioTypeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            portfolioTypeView.heightAnchor.constraint(equalToConstant: 56)
            ])
    }
    
    func addStatusBarColor() {
        let statusBarView = UIView()
        statusBarView.backgroundColor = UIColor.colorWithHexString(hex: "#033364")
        statusBarView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(statusBarView)
        
        NSLayoutConstraint.activate([
            statusBarView.topAnchor.constraint(equalTo: view.topAnchor),
            statusBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            statusBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    func addSummaryView() {
        summaryView.isHidden = true
        view.addSubview(summaryView)
        summaryView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            summaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            summaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            summaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func addTableView() {
        tableView.register(HoldingCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: portfolioTypeView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: summaryView.topAnchor)
        ])
    }
    
    func addExpandedProfileSummaryView() {
        expandedProfileSummaryView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(expandedProfileSummaryView)
        NSLayoutConstraint.activate([
            expandedProfileSummaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            expandedProfileSummaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            expandedProfileSummaryView.bottomAnchor.constraint(equalTo: summaryView.topAnchor),
        ])
        expandedProfileSummaryView.isHidden = true
    }

    private func setupStateChangeCallback() {
        model.onStateChange = { [weak self] (state : State) in
            guard let self else { return }
            if case .loaded = state {
                ProgressView.shared.hideProgress()
                self.tableView.reloadData()
                self.summaryView.configure(
                    summary: self.model.portfolioSummary(),
                    expanded: self.model.isSummaryExpanded
                )
                summaryView.isHidden = false
                
                self.expandedProfileSummaryView.configure(
                    summary: self.model.portfolioSummary(),
                    expanded: self.model.isSummaryExpanded
                )
                setBottomSuperArea()
            } else if case .error(let error) = state {
                ProgressView.shared.hideProgress()
                showAlert(title: "Error", message: error, on : self) {
                    self.model.fetchHoldings()
                }
            } else {
                ProgressView.shared.showProgress()
            }
        }
    }
    
    private func setupToggleCallback() {
        summaryView.onToggle = { [weak self] in
            guard let self else { return }
            self.model.isSummaryExpanded.toggle()
            self.summaryView.configure(
                summary: self.model.portfolioSummary(),
                expanded: self.model.isSummaryExpanded
            )
            self.expandedProfileSummaryView.configure(
                summary: self.model.portfolioSummary(),
                expanded: self.model.isSummaryExpanded
            )
            UIView.transition(with: self.view, duration: 0.25, options: .transitionCrossDissolve) {
                self.expandedProfileSummaryView.isHidden = !self.model.isSummaryExpanded
            }
        }
    }
    
    func showAlert(title: String, message: String, on viewController: UIViewController, retryCallback: @escaping () -> ()) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "Retry", style: .default) {_ in
            retryCallback()
        }
        alert.addAction(okAction)
        viewController.present(alert, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.holdings.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HoldingCell
        cell.configure(with: model.cellViewModel(at: indexPath.row))
        return cell
    }
}

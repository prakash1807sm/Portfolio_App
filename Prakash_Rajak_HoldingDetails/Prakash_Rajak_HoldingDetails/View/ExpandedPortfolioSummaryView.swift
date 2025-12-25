//
//  ExpandedPortfolioSummaryView.swift
//  Prakash_Rajak_HoldingDetails
//
//  Created by Prakash Rajak on 25/12/25.
//

import UIKit

final class ExpandedPortfolioSummaryView: UIView {
    
    private let currentValueStack = UIStackView()
    private let currentValueTextLabel = UILabel()
    private let currentValueLabel = UILabel()
    
    private let totalInvestentView = UIStackView()
    private let totalInvestmentLabel = UILabel()
    private let totalInvestmentValLabel = UILabel()
    
    private let todayProfitAndLossView = UIStackView()
    private let todayProfitLossLabel = UILabel()
    private let todayProfitLossValueLabel = UILabel()
    
    private let dividerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setup() {
        self.backgroundColor = UIColor.colorWithHexString(hex: "#F5F5F5")
        addCurrenValueView()
        addTotalInvestmentView()
        addProfitAndLossView()
        addDivider()
    }
    
    func addCurrenValueView() {
        self.currentValueStack.backgroundColor = UIColor.colorWithHexString(hex: "#F5F5F5")
        currentValueTextLabel.text = "Current value"
        currentValueTextLabel.font = .systemFont(ofSize: 16)
        currentValueTextLabel.textColor = UIColor.colorWithHexString(hex: "#5E5E5E")

    
        currentValueLabel.font = .systemFont(ofSize: 15, weight: .medium)
        currentValueLabel.textColor = UIColor.colorWithHexString(hex: "#5E5E5E")
        
        
        currentValueStack.addArrangedSubview(currentValueTextLabel)
        currentValueStack.addArrangedSubview(currentValueLabel)
        currentValueStack.axis = .horizontal
        currentValueStack.alignment = .center
        currentValueStack.distribution = .equalSpacing
        currentValueStack.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(currentValueStack)
        NSLayoutConstraint.activate([
            currentValueStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            currentValueStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            currentValueStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 20)
        ])
    }
    
    func addTotalInvestmentView() {
        self.totalInvestentView.backgroundColor = UIColor.colorWithHexString(hex: "#F5F5F5")
        totalInvestmentLabel.text = "Total investment"
        totalInvestmentLabel.font = .systemFont(ofSize: 16)
        totalInvestmentLabel.textColor = UIColor.colorWithHexString(hex: "#5E5E5E")

    
        totalInvestmentValLabel.font = .systemFont(ofSize: 14, weight: .medium)
        totalInvestmentValLabel.textColor = UIColor.colorWithHexString(hex: "#5E5E5E")
        
        totalInvestentView.addArrangedSubview(totalInvestmentLabel)
        totalInvestentView.addArrangedSubview(totalInvestmentValLabel)
        totalInvestentView.axis = .horizontal
        totalInvestentView.alignment = .center
        totalInvestentView.distribution = .equalSpacing
        totalInvestentView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(totalInvestentView)
        NSLayoutConstraint.activate([
            totalInvestentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            totalInvestentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            totalInvestentView.topAnchor.constraint(equalTo: currentValueStack.bottomAnchor, constant: 24)
        ])
    }
    
    func addProfitAndLossView() {
        self.todayProfitAndLossView.backgroundColor = UIColor.colorWithHexString(hex: "#F5F5F5")
        todayProfitLossLabel.text = "Today's Profit & Loss"
        todayProfitLossLabel.font = .systemFont(ofSize: 16)
        todayProfitLossLabel.textColor = UIColor.colorWithHexString(hex: "#5E5E5E")

        todayProfitLossValueLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        todayProfitAndLossView.addArrangedSubview(todayProfitLossLabel)
        todayProfitAndLossView.addArrangedSubview(todayProfitLossValueLabel)
        todayProfitAndLossView.axis = .horizontal
        todayProfitAndLossView.alignment = .center
        todayProfitAndLossView.distribution = .equalSpacing
        todayProfitAndLossView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(todayProfitAndLossView)
        NSLayoutConstraint.activate([
            todayProfitAndLossView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            todayProfitAndLossView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            todayProfitAndLossView.topAnchor.constraint(equalTo: totalInvestentView.bottomAnchor, constant: 24)
        ])
    }
    
    func addDivider() {
        let divider = UIView()
        divider.backgroundColor = UIColor.colorWithHexString(hex: "#cfcfcf")
        divider.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(divider)
        NSLayoutConstraint.activate([
            divider.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            divider.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            divider.bottomAnchor.constraint(equalTo: todayProfitAndLossView.bottomAnchor, constant: 24),
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }

    func configure(summary: PortfolioSummary, expanded: Bool) {
        currentValueLabel.text = "₹ " + String(format: "%.2f", summary.currentValue)
        totalInvestmentValLabel.text = "₹ " + String(format: "%.2f", summary.totalInvestment)
        
        if summary.todayPNL >= 0 {
            todayProfitLossValueLabel.text = "₹ " + String(format: "%.2f", summary.todayPNL)
            todayProfitLossValueLabel.textColor = UIColor.colorWithHexString(hex: "#33d6a1")
        } else {
            todayProfitLossValueLabel.text = "-₹" + String(format: "%.2f", abs(summary.todayPNL))
            todayProfitLossValueLabel.textColor = UIColor.colorWithHexString(hex: "#CD5963")
        }
    }
}

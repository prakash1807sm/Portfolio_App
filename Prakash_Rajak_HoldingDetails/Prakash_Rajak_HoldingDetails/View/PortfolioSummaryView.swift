//
//  PortfolioSummaryView.swift
//  Prakash_Rajak_HoldingDetails
//
//  Created by Prakash Rajak on 25/12/25.
//

import UIKit


final class PortfolioSummaryView: UIView {

    var isExpanded = false
    var onToggle: (() -> Void)?
    
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
    
    private let profitLossLabel = UILabel()
    private let toggleIconView = UIImageView(image: UIImage(named: "chevron.down"))
    private let profitLossValueLabel = UILabel()
    private let profitlossValuePercentLabel = UILabel()
    
    private let expandedView  = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setup() {
        self.backgroundColor = UIColor.colorWithHexString(hex: "#F5F5F5")
        addProfitLossView()
    }
    
    func addProfitLossView() {
        profitLossLabel.text = "Profit & Loss"
        profitLossLabel.font = .systemFont(ofSize: 16)
        profitLossLabel.textColor = .black
        
        profitLossLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(profitLossLabel)
        NSLayoutConstraint.activate([
            profitLossLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            profitLossLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            profitLossLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24),
        ])
        
        toggleIconView.image = UIImage(systemName: "chevron.up")
        toggleIconView.tintColor = .gray
        toggleIconView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleIconTapped))
        toggleIconView.addGestureRecognizer(tapGesture)
        
        toggleIconView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(toggleIconView)
        NSLayoutConstraint.activate([
            toggleIconView.leadingAnchor.constraint(equalTo: self.profitLossLabel.trailingAnchor, constant: 4),
            toggleIconView.centerYAnchor.constraint(equalTo: self.profitLossLabel.centerYAnchor, constant: 0),
            
        ])
        
        
        profitlossValuePercentLabel.text = "(2.44%)"
        profitlossValuePercentLabel.font = .systemFont(ofSize: 12)
        profitlossValuePercentLabel.textColor = .red
        
        profitlossValuePercentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(profitlossValuePercentLabel)
        NSLayoutConstraint.activate([
            profitlossValuePercentLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            profitlossValuePercentLabel.centerYAnchor.constraint(equalTo: profitLossLabel.centerYAnchor, constant: 0),
        ])
        
        profitLossValueLabel.text = "697"
        profitLossValueLabel.font = .systemFont(ofSize: 16)
        profitLossValueLabel.textColor = .black
        
        
        profitLossValueLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(profitLossValueLabel)
        NSLayoutConstraint.activate([
            profitLossValueLabel.trailingAnchor.constraint(equalTo: self.profitlossValuePercentLabel.leadingAnchor, constant: -2),
            profitLossValueLabel.centerYAnchor.constraint(equalTo: profitLossLabel.centerYAnchor, constant: 0),
        ])
    }
    
    @objc func toggleIconTapped() {
        onToggle?()
    }

    func configure(summary: PortfolioSummary, expanded: Bool) {
        let percent = (Double)(summary.totalPNL / summary.totalInvestment)
        profitlossValuePercentLabel.text =  "(" +  String(format: "%.2f", percent) + ")%"
        
        if summary.totalPNL >= 0 {
            profitLossValueLabel.text = "₹" + String(format: "%.2f", summary.totalPNL)
            profitLossValueLabel.textColor = UIColor.colorWithHexString(hex: "#33d6a1")
            profitlossValuePercentLabel.textColor = UIColor.colorWithHexString(hex: "#33d6a1")
        } else {
            profitLossValueLabel.text = "-₹" + String(format: "%.2f", summary.totalPNL)
            profitLossValueLabel.textColor = UIColor.colorWithHexString(hex: "#CD5963")
            profitlossValuePercentLabel.textColor = UIColor.colorWithHexString(hex: "#CD5963")
        }
        toggleIconView.image = expanded ?  UIImage(systemName: "chevron.down") : UIImage(systemName: "chevron.up")

    }
}

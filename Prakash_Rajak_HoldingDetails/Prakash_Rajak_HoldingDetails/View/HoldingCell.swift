//
//  HoldingCell.swift
//  Prakash_Rajak_HoldingDetails
//
//  Created by Prakash Rajak on 25/12/25.
//

import UIKit

class HoldingCell: UITableViewCell {
    
    private let topSeparator = UIView()

    private let symbolLabel = UILabel()
    private let ltpValueLabel = UILabel()
    private let ltpTextLabel = UILabel()
    
    private let netQtyTextLabel = UILabel()
    private let qtyLabel = UILabel()
    
    private let pnlTextLabel = UILabel()
    private let pnlLabel = UILabel()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupUI() {
        setupTopSeparator()
        addSymbolLabel()
        addLtpValueLabel()
        addLtpTextLabel()
        addNetQuantityTextLabel()
        addNetQuantityValueLabel()
        profitAndLossValueLabel()
        profitAndLossTextLabel()
    }
    
    private func setupTopSeparator() {
        topSeparator.backgroundColor = .separator
        topSeparator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(topSeparator)
        
        NSLayoutConstraint.activate([
            topSeparator.topAnchor.constraint(equalTo: contentView.topAnchor),
            topSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            topSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            topSeparator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
    
    
    func addSymbolLabel() {
        symbolLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(symbolLabel)
        NSLayoutConstraint.activate([
            symbolLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            symbolLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
        ])
    }
    
    func addLtpValueLabel() {
        ltpValueLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(ltpValueLabel)
        NSLayoutConstraint.activate([
            ltpValueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            ltpValueLabel.centerYAnchor.constraint(equalTo: symbolLabel.centerYAnchor, constant: 0),
        ])
    }
    
    func addLtpTextLabel() {
        ltpTextLabel.text = "LTP: "
        ltpTextLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        ltpTextLabel.textColor = .secondaryLabel
        ltpTextLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(ltpTextLabel)
        NSLayoutConstraint.activate([
            ltpTextLabel.trailingAnchor.constraint(equalTo: ltpValueLabel.leadingAnchor, constant: -4),
            ltpTextLabel.centerYAnchor.constraint(equalTo: ltpValueLabel.centerYAnchor, constant: 0),
        ])
    }
    
    func addNetQuantityTextLabel() {
        netQtyTextLabel.text = "NET QTY: "
        netQtyTextLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        netQtyTextLabel.textColor = .secondaryLabel
        netQtyTextLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(netQtyTextLabel)
        NSLayoutConstraint.activate([
            netQtyTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            netQtyTextLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor, constant: 24),
            netQtyTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func addNetQuantityValueLabel() {
        qtyLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(qtyLabel)
        NSLayoutConstraint.activate([
            qtyLabel.leadingAnchor.constraint(equalTo: netQtyTextLabel.trailingAnchor, constant: 4),
            qtyLabel.centerYAnchor.constraint(equalTo: netQtyTextLabel.centerYAnchor, constant: 0),
        ])
    }
    
    func profitAndLossValueLabel() {
        pnlLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pnlLabel)
        NSLayoutConstraint.activate([
            pnlLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            pnlLabel.centerYAnchor.constraint(equalTo: netQtyTextLabel.centerYAnchor, constant: 0),
        ])
    }
    
    func profitAndLossTextLabel() {
        pnlTextLabel.text = "P&L: "
        pnlTextLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        pnlTextLabel.textColor = .secondaryLabel
        pnlTextLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pnlTextLabel)
        NSLayoutConstraint.activate([
            pnlTextLabel.trailingAnchor.constraint(equalTo: pnlLabel.leadingAnchor, constant: -4),
            pnlTextLabel.centerYAnchor.constraint(equalTo: pnlLabel.centerYAnchor, constant: 0),
        ])
    }
    

    func configure(with vm: HoldingCellViewModel) {
        symbolLabel.text = vm.symbol
        ltpValueLabel.text = vm.ltpText
        qtyLabel.text = vm.quantityText
        pnlLabel.text = vm.pnlText
        pnlLabel.textColor = vm.pnlColor
    }
}

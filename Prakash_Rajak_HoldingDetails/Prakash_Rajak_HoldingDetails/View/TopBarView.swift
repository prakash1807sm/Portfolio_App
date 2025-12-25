//
//  TopBarView.swift
//  Prakash_Rajak_HoldingDetails
//
//  Created by Prakash Rajak on 25/12/25.
//


import UIKit

final class TopBarView: UIView {

    private let profileButton = UIButton(type: .system)
    private let titleLabel = UILabel()
    private let sortButton = UIButton(type: .system)
    private let searchButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.colorWithHexString(hex: "#033364")
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("fatal error")
    }

    private func setupUI() {
        profileButton.isUserInteractionEnabled = false
        profileButton.setImage(UIImage(systemName: "person.circle"), for: .normal)
        profileButton.tintColor = .white

        titleLabel.text = "Portfolio"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 18, weight: .medium)

        sortButton.setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .normal)
        sortButton.isUserInteractionEnabled = false
        sortButton.tintColor = .white

        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.isUserInteractionEnabled = false
        searchButton.tintColor = .white

        let rightStack = UIStackView(arrangedSubviews: [sortButton, searchButton])
        rightStack.axis = .horizontal
        rightStack.spacing = 16

        addSubview(profileButton)
        addSubview(titleLabel)
        addSubview(rightStack)

        profileButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        rightStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            profileButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileButton.widthAnchor.constraint(equalToConstant: 28),
            profileButton.heightAnchor.constraint(equalToConstant: 28),

            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: profileButton.trailingAnchor, constant: 12),

            rightStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            rightStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

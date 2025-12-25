//
//  PortfolioSegmentView.swift
//  Prakash_Rajak_HoldingDetails
//
//  Created by Prakash Rajak on 25/12/25.
//

import UIKit

final class PortfolioSegmentView: UIView {

    private let positionsButton = UIButton(type: .system)
    private let holdingsButton = UIButton(type: .system)
    private let underlineView = UIView()
    private var underlineCenterXConstraint: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupUI()
        selectSegment(isPositions: false)
    }

    required init?(coder: NSCoder) {
        fatalError("fatal error")
    }

    private func setupUI() {
        positionsButton.setTitle("POSITIONS", for: .normal)
        holdingsButton.setTitle("HOLDINGS", for: .normal)
        positionsButton.isUserInteractionEnabled = false
        holdingsButton.isUserInteractionEnabled = false

        [positionsButton, holdingsButton].forEach {
            $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
            $0.setTitleColor(.lightGray, for: .normal)
        }

        let stack = UIStackView(arrangedSubviews: [positionsButton, holdingsButton])
        stack.axis = .horizontal
        stack.distribution = .fillEqually

        underlineView.backgroundColor = UIColor.colorWithHexString(hex: "#d1d1d1")

        addSubview(stack)
        addSubview(underlineView)

        stack.translatesAutoresizingMaskIntoConstraints = false
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineCenterXConstraint = underlineView.centerXAnchor.constraint(equalTo: holdingsButton.centerXAnchor)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),

            underlineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            underlineView.heightAnchor.constraint(equalToConstant: 2),
            underlineView.widthAnchor.constraint(equalToConstant: 70),
            underlineCenterXConstraint
        ])
    }

    @objc private func positionsTapped() {
        selectSegment(isPositions: true)
    }

    @objc private func holdingsTapped() {
        selectSegment(isPositions: false)
    }

    private func selectSegment(isPositions: Bool) {
        positionsButton.setTitleColor(isPositions ? .black : .lightGray, for: .normal)
        holdingsButton.setTitleColor(isPositions ? .lightGray : .black, for: .normal)
        removeConstraint(underlineCenterXConstraint)
        if isPositions {
            underlineCenterXConstraint =  underlineView.centerXAnchor.constraint(equalTo: positionsButton.centerXAnchor)

        } else {
            underlineCenterXConstraint =  underlineView.centerXAnchor.constraint(equalTo: holdingsButton.centerXAnchor)
        }
        underlineCenterXConstraint.isActive = true
        
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
    }
}

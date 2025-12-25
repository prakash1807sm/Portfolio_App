//
//  ProgressView.swift
//  Prakash_Rajak_HoldingDetails
//
//  Created by Prakash Rajak on 25/12/25.
//


import UIKit

final class ProgressView {

    static let shared = ProgressView()

    private var blurView: UIVisualEffectView?
    private var activityIndicator: UIActivityIndicatorView?

    private init() {}

    func showProgress() {
        DispatchQueue.main.async {
            guard
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let window = windowScene.windows.first
            else { return }

            if self.blurView != nil { return }

            let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.frame = window.bounds
            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            let indicator = UIActivityIndicatorView(style: .large)
            indicator.color = UIColor.colorWithHexString(hex: "#033364")
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.startAnimating()

            blurView.contentView.addSubview(indicator)
            NSLayoutConstraint.activate([
                indicator.centerXAnchor.constraint(equalTo: blurView.centerXAnchor),
                indicator.centerYAnchor.constraint(equalTo: blurView.centerYAnchor)
            ])

            window.addSubview(blurView)

            self.blurView = blurView
            self.activityIndicator = indicator
        }
    }

    func hideProgress() {
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
            self.blurView?.removeFromSuperview()
            self.blurView = nil
            self.activityIndicator = nil
        }
    }
}

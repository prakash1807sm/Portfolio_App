//
//  ViewModel.swift
//  Prakash_Rajak_HoldingDetails
//
//  Created by Prakash Rajak on 24/12/25.
//

import UIKit


enum State {
    case loading
    case loaded
    case error(String)
}

final class ViewModel {
    var holdings: [UserHolding] = []

    var onStateChange: ((State) -> Void)?

    var isSummaryExpanded = false
    var responseFetchCase : FetchHoldingResponse

    init(responseFetchCase: FetchHoldingResponse) {
        self.responseFetchCase = responseFetchCase
    }

    func fetchHoldings() {
        onStateChange?(.loading)
        ProgressView.shared.showProgress()
        responseFetchCase.execute { [weak self] result in
            ProgressView.shared.hideProgress()
            DispatchQueue.main.async {
                switch result {
                case .success(let holdings):
                    self?.holdings = holdings
                    self?.onStateChange?(.loaded)
                case .failure(let error):
                    self?.onStateChange?(.error(error.localizedDescription))
                }
            }
        }
    }

    func cellViewModel(at index: Int) -> HoldingCellViewModel {
        let h = holdings[index]
        let pnl = (h.ltp - h.avgPrice) * Double(h.quantity)

        return HoldingCellViewModel(
            symbol: h.symbol,
            quantityText: "\(h.quantity)",
            ltpText: "₹ \(h.ltp)",
            pnlText:  pnl >= 0 ? "₹ \(String(format: "%.2f", pnl))" : "-" + "₹\(String(format: "%.2f", abs(pnl)))",
            pnlColor: pnl >= 0 ? UIColor.colorWithHexString(hex: "#33d6a1") : UIColor.colorWithHexString(hex: "#CD5963")
        )
    }

    func portfolioSummary() -> PortfolioSummary {
        let currentValue = holdings.reduce(0) { $0 + Double($1.quantity) * $1.ltp }
        let totalInvestment = holdings.reduce(0) { $0 + Double($1.quantity) * $1.avgPrice }
        let totalPNL = currentValue - totalInvestment
        var todayPNL = 0.0
        for holding in holdings {
            todayPNL = todayPNL + Double(holding.quantity) * (holding.close - holding.ltp) //Note - In the document it is (close - ltp) but it should be (ltp - close) of all holdings
        }
        return PortfolioSummary(
            currentValue: currentValue,
            totalInvestment: totalInvestment,
            todayPNL: todayPNL,
            totalPNL: totalPNL
        )
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

//
//  Prakash_Rajak_HoldingDetailsTests.swift
//  Prakash_Rajak_HoldingDetailsTests
//
//  Created by Prakash Rajak on 24/12/25.
//

import XCTest
@testable import Prakash_Rajak_HoldingDetails

final class Prakash_Rajak_HoldingDetailsTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testPortfolioCalculation() throws {
        let expectation = expectation(description: "Holdings Calculator")
        let holdings = [
            UserHolding(symbol: "Finance",
                        quantity: 10,
                        ltp: 100,
                        avgPrice: 90,
                        close: 95)
        ]
        
        let vm = ViewModel(responseFetchCase: FetchHoldingResponseForTest(holdings))
        
        vm.onStateChange = { state in
            if case .loaded = state {
                expectation.fulfill()
            }
        }
        vm.fetchHoldings()
        waitForExpectations(timeout: 1)
        
        let summary = vm.portfolioSummary()
        XCTAssertEqual(summary.currentValue, 1000.0)
        XCTAssertEqual(summary.totalInvestment, 900.0)
        XCTAssertEqual(summary.totalPNL, 100.0)
        XCTAssertEqual(summary.todayPNL, -50.0)
    }
    
    func testCellColorPositivePNL() throws {
        let expectation = expectation(description: "P&L Color")
        
        let holding = UserHolding(symbol: "A",
                                  quantity: 1,
                                  ltp: 100,
                                  avgPrice: 90,
                                  close: 95)
        
        let vm = ViewModel(responseFetchCase: FetchHoldingResponseForTest([holding]))
        
        vm.onStateChange = { state in
            if case .loaded = state {
                expectation.fulfill()
            }
        }
        
        vm.fetchHoldings()
        waitForExpectations(timeout: 1)
        
        let cellVM = vm.cellViewModel(at: 0)
        XCTAssertEqual(cellVM.pnlColor, UIColor.colorWithHexString(hex: "#33d6a1"))
    }
}

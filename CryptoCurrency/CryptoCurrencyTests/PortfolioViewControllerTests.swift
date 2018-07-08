//
//  PortfolioViewControllerTests.swift
//  CryptoCurrencyTests
//
//  Created by Michael Aidoo on 2018-07-08.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import XCTest
@testable import CryptoCurrency

class PortfolioViewControllerTests: XCTestCase {

    var sut: PortfolioViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let portfolioVC = storyboard.instantiateViewController(withIdentifier: "PortfolioViewController") as! PortfolioViewController
        sut = portfolioVC
        _ = sut.view
    }
    
    func test_afterViewLoads_tableViewisNotNil() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_afterViewLoads_setsDatasource() {
        XCTAssertTrue(sut.tableView.dataSource is PortfolioDataSource)
    }
    
    func test_afterViewLoads_setsDelegateSource() {
        XCTAssertTrue(sut.tableView.delegate is PortfolioDelegateSource)
    }
}

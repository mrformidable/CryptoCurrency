//
//  CurrencyListViewControllerTests.swift
//  CryptoCurrencyTests
//
//  Created by Michael Aidoo on 2018-07-07.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import XCTest
@testable import CryptoCurrency

class CurrencyListViewControllerTests: XCTestCase {

    var sut: CurrencyListViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let currencyListVC = storyboard.instantiateViewController(withIdentifier: "CurrencyListViewController") as! CurrencyListViewController
        sut = currencyListVC
        _ = sut.view
    }
    
    func test_afterViewLoads_tableViewisNotNil() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func test_afterViewLoads_setsDatasource() {
        XCTAssertTrue(sut.tableView.dataSource is CurrencyListDataSource)
    }
    
    func test_afterViewLoads_setsDelegateSource() {
        XCTAssertTrue(sut.tableView.delegate is CurrencyListDelegateSource)
    }

}

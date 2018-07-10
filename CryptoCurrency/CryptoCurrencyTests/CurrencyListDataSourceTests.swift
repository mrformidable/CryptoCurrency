//
//  CurrencyListDataSourceTests.swift
//  CryptoCurrencyTests
//
//  Created by Michael Aidoo on 2018-07-10.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import XCTest
@testable import CryptoCurrency

class CurrencyListDataSourceTests: XCTestCase {
    
    var sut: CurrencyListDataSource!
    var tableView: UITableView!
    var viewController: CurrencyListViewController!
    
    override func setUp() {
        sut = CurrencyListDataSource()
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        viewController = storyboard.instantiateViewController(withIdentifier: "CurrencyListViewController") as? CurrencyListViewController
        _ = viewController.view
        tableView = viewController.tableView
        tableView.dataSource = sut

    }
    
    func test_numberOfSections_isEqualToOne() {
        XCTAssertEqual(tableView.numberOfSections, 1)
    }
    
    func test_numberOfRows_increasesByOne_whenCurrencyIsAdded() {
        var currencies: [Currency] = []
        let currency = Currency(name: "Currecny 1", symbol: "AAA", marketPrice: 10)
        currencies.append(currency)
        sut.currencies = currencies
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
    }
    
    func test_numberOfRows_increments_whenCurrencyIsAdded() {
        var currencies: [Currency] = []
        let currency1 = Currency(name: "Currecny 1", symbol: "AAA", marketPrice: 10)
        let currency2 = Currency(name: "Currency 2", symbol: "AAA", marketPrice: 10)
        let currency3 = Currency(name: "Currency 3", symbol: "AAA", marketPrice: 10)
        currencies.append(currency1)
        currencies.append(currency2)
        sut.currencies = currencies
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
        
        sut.currencies.append(currency3)
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 3)

    }
    
    func test_cellForRow_returnsCurrencyCell() {
        sut.currencies.append(Currency(name: "Currency Test", symbol: "abc", marketPrice: 1.0))
        tableView.reloadData()
        let cell = tableView.cellForRow(at: IndexPath.init(row: 0, section: 0))
        XCTAssertTrue(cell is CurrencyTableViewCell)
    }
    
    func test_cellForRow_dequeuesCellFromTableView() {
        let mockTableView = MockTableView.mockTableView(dataSource: sut)
        sut.currencies.append(Currency(name: "Currency Test", symbol: "abc", marketPrice: 1.0))
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath.init(row: 0, section: 0))
        
        XCTAssertTrue(mockTableView.dequeueCalled)
    }
 
    func test_cellForRow_callsConfigCellViewModel() {
        let mockTableView = MockTableView.mockTableView(dataSource: sut)
        let currency = Currency(name: "Currency Test", symbol: "abc", marketPrice: 1.0)
        sut.currencies.append(currency)
        mockTableView.reloadData()
        
        guard let cell = mockTableView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as? MockCurrencyCell else {
            XCTFail()
            return
        }
        XCTAssertEqual(cell.cellViewModel?.name, currency.name)
        XCTAssertEqual(cell.cellViewModel?.symbol, currency.symbol)
        XCTAssertEqual(cell.cellViewModel?.marketPrice, currency.marketPrice)
    }
    
}


extension CurrencyListDataSourceTests {
    class MockTableView: UITableView {
        private(set) var dequeueCalled = false
        
        class func mockTableView(dataSource: UITableViewDataSource) -> MockTableView {
            let mockTableView = MockTableView(frame: CGRect.init(x: 0, y: 0, width: 350, height: 667), style: .plain)
            mockTableView.register(MockCurrencyCell.self, forCellReuseIdentifier: "CurrencyTableViewCell")
            mockTableView.dataSource = dataSource
            return mockTableView
        }
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            dequeueCalled = true
            
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
    
    class MockCurrencyCell: CurrencyTableViewCell {
        var cellViewModel: CurrencyCellViewModel?
        
        override func configureCell(for viewModel: CurrencyCellViewModel) {
            self.cellViewModel = viewModel
        }
    }
}

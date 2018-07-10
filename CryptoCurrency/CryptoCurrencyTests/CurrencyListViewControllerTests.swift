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
    
    func test_currencyListViewController_hasChangeThemeBarButton_selfAsTarget() {
        let target = sut.navigationItem.rightBarButtonItem?.target
        XCTAssertEqual(target as? UIViewController, sut)
    }
    
    func test_tableViewSelection_pushesPortfolioVC() {
        let mockNavigationController = MockNavigationController(rootViewController: sut)

        UIApplication.shared.keyWindow?.rootViewController = mockNavigationController
        sut.loadViewIfNeeded()
        
        let indexPath = IndexPath(row: 0, section: 0)
        NotificationCenter.default.post(name: .handleCurrencySelection, object: indexPath)
        
        sut.performSegue(withIdentifier: Constants.SegueIdentifiers.showPortfolioController, sender: self)
    
        guard let portfolioViewController = mockNavigationController.lastViewControllerPushed as? PortfolioViewController else {
            XCTFail()
            return
        }
        
        portfolioViewController.loadView()
        let currency = Currency(name: "Test Currency", symbol: "TC", marketPrice: 9999)
        portfolioViewController.currency = currency
        
        XCTAssertNotNil(portfolioViewController.tableView)
        XCTAssertEqual(portfolioViewController.currency?.name, currency.name)
    }
    
}

extension CurrencyListViewControllerTests {
    class MockNavigationController: UINavigationController {
        
        var lastViewControllerPushed: UIViewController?
        
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: animated)
            lastViewControllerPushed = viewController
        }
    }
    
}

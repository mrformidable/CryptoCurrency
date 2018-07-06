//
//  CurrencyViewModelTests.swift
//  CryptoCurrencyTests
//
//  Created by Michael Aidoo on 2018-07-06.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation
import XCTest

@testable import CryptoCurrency

class CurrencyViewModelTests: XCTestCase {
    
    var sut: CurrencyViewModel!
    let mockService = MockNetworkService()
    
    override func setUp() {
        super.setUp()
        sut = CurrencyViewModel(service: mockService)
    }
    
    func test_viewModelCalls_loadCurrenciesMethod() {
        mockService.loadCurrencies { _ in }
        XCTAssertTrue(mockService.calledLoadCurrencies)
    }
    
    func test_viewModelCalls_completionMethod() {
        let expection = XCTestExpectation(description: "completion call")
        sut.fetchCurrencies { _ in
            expection.fulfill()
        }
        wait(for: [expection], timeout: 3)
    }
    
    func test_viewModel_fetchesCurencies() {
        let expection = XCTestExpectation(description: "currency fetch")
        var currencies: [Currency] = []
        
        sut.fetchCurrencies { values in
            if let _currencies = values {
                currencies = _currencies
            }
            expection.fulfill()
            
        }
        wait(for: [expection], timeout: 5)
        XCTAssertTrue(currencies.count > 0)
    }
    
    struct CurrencyStubGenerator {
        static func makeCurrency(_ name: String = "", symbol: String = "", marketPrice: Double = 0.0) -> Currency {
            return Currency(name: name, symbol: symbol, marketPrice: marketPrice)
        }
    }
    
    class MockNetworkService: NetworkService {
        private(set) var calledLoadCurrencies = false
        
        func loadCurrencies(_ completion: @escaping ([Currency]?) -> Void) {
            calledLoadCurrencies = true
            var currencies: [Currency] = []
            let c1 = CurrencyStubGenerator.makeCurrency("Sample 1", symbol: "S1", marketPrice: 1.0)
            let c2 = CurrencyStubGenerator.makeCurrency("Sample 2", symbol: "S2", marketPrice: 1.0)
            let c3 = CurrencyStubGenerator.makeCurrency("Sample 3", symbol: "S3", marketPrice: 1.0)
            currencies = [c1, c2, c3]
            completion(currencies)
        }
    }
}


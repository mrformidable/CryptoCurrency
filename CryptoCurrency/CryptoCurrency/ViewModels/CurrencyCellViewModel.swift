//
//  CurrencyCellViewModel.swift
//  CryptoCurrency
//
//  Created by Michael Aidoo on 2018-07-06.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation

struct CurrencyCellViewModel {
    
    let name: String
    let symbol: String
    let marketPrice: Double
    
    init(_ currency: Currency) {
        self.name = currency.name
        self.symbol = currency.symbol
        self.marketPrice = currency.marketPrice
    }
}

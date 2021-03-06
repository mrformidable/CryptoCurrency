//
//  CurrencyFactory.swift
//  CryptoCurrency
//
//  Created by Michael Aidoo on 2018-07-06.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation

struct CurrencyFactory {
    static func createCurrency(name: String, symbol: String, marketPrice: Double) -> Currency {
        return Currency(name: name, symbol: symbol, marketPrice: marketPrice)
    }
}

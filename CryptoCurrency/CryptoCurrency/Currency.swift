//
//  Currency.swift
//  CryptoCurrency
//
//  Created by Michael Aidoo on 2018-07-06.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation

struct Currency {
    let name: String
    let symbol: String
    var marketPrice: Double
}

struct CurrencyNames {
    static let bitcoin = "Bitcoin"
    static let ripple = "Ripple"
    static let erethereum = "Erethereum"
}

struct CurrencySymbols {
    static let bitcoin = "BTC"
    static let ripple = "XRP"
    static let erethereum = "ERT"
}




//
//  NetworkService.swift
//  CryptoCurrency
//
//  Created by Michael Aidoo on 2018-07-06.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation

protocol NetworkService {
    func loadCurrencies(_ completion: @escaping ([Currency]?) -> Void)
}

struct CurrencyNetworkService: NetworkService {
    func loadCurrencies(_ completion: @escaping ([Currency]?) -> Void) {
        // Fake Network
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 2) {
            let bitcoin = CurrencyFactory.createCurrency(name: CryptoCurrency.Bitcoin.name, symbol: CryptoCurrency.Bitcoin.symbol, marketPrice: 6555.98)
            let ripple = CurrencyFactory.createCurrency(name: CryptoCurrency.Ripple.name, symbol: CryptoCurrency.Ripple.symbol, marketPrice: 0.471470)
            let ethereum = CurrencyFactory.createCurrency(name: CryptoCurrency.Ethereum.name, symbol: CryptoCurrency.Ethereum.symbol, marketPrice: 471.85)
            let litecoin = CurrencyFactory.createCurrency(name: CryptoCurrency.Litecoin.name, symbol: CryptoCurrency.Litecoin.symbol, marketPrice: 82.61)
            let dash = CurrencyFactory.createCurrency(name: CryptoCurrency.Dash.name, symbol: CryptoCurrency.Dash.symbol, marketPrice: 241.11)
            let tron = CurrencyFactory.createCurrency(name: CryptoCurrency.Tron.name, symbol: CryptoCurrency.Tron.symbol, marketPrice: 0.036663)
            let neo = CurrencyFactory.createCurrency(name: CryptoCurrency.Neo.name, symbol: CryptoCurrency.Neo.symbol, marketPrice: 36.96)
            let tether = CurrencyFactory.createCurrency(name: CryptoCurrency.Tether.name, symbol: CryptoCurrency.Tether.symbol, marketPrice: 1.00)
            completion([bitcoin, ripple, ethereum, tron, litecoin, dash, neo, tether])
        }
    }
}



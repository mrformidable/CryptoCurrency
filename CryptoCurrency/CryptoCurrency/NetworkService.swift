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
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 3.5) {
            let bitcoin = CurrencyFactory.createCurrency(name: CurrencyNames.bitcoin, symbol: CurrencySymbols.bitcoin, marketPrice: 6_000)
            let ripple = CurrencyFactory.createCurrency(name: CurrencyNames.ripple, symbol: CurrencySymbols.ripple, marketPrice: 2_000)
            let erethereum = CurrencyFactory.createCurrency(name: CurrencyNames.erethereum, symbol: CurrencySymbols.erethereum, marketPrice: 4_000)
            completion([bitcoin, ripple, erethereum])
        }
    }
}



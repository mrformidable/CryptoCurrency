//
//  CurrencyViewModel.swift
//  CryptoCurrency
//
//  Created by Michael Aidoo on 2018-07-06.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation

struct CurrencyViewModel {
    
    let service: NetworkService
    
    init(service: NetworkService = CurrencyNetworkService()) {
        self.service = service
    }
    
    func fetchCurrencies(_ completion: @escaping ([Currency]?) -> Void) {
        service.loadCurrencies { (currencies) in
            if let currencies = currencies {
                completion(currencies)
            }
        }
    }
}


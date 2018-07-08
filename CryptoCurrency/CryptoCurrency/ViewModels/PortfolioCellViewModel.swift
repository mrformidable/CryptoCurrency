//
//  PortfolioCellViewModel.swift
//  CryptoCurrency
//
//  Created by Michael Aidoo on 2018-07-07.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation

struct PortfolioCellViewModel {
    
    let purchasePrice: Double
    let quantity: Int
    let currency: Currency
    
    init(asset: Asset) {
        self.purchasePrice = asset.purchasePrice
        self.quantity = asset.quantity
        self.currency = asset.currency
    }
}

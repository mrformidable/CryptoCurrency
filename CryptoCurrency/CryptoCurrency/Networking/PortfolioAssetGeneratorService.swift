//
//  PortfolioAssetGeneratorService.swift
//  CryptoCurrency
//
//  Created by Michael Aidoo on 2018-07-07.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation

protocol PortfolioAssetCreatable {
    func createAsset(_ currency: Currency) -> Asset
}

struct PortfolioAssetGeneratorService: PortfolioAssetCreatable {
    // Create fake Assets for certain currencies
    func createAsset(_ currency: Currency) -> Asset {
        var purchasePrice: Double = 0
        var quantity = 0
        
        if CryptoCurrency.Bitcoin.name == currency.name {
            purchasePrice = 6100.28
            quantity = 5
        } else if CryptoCurrency.Ethereum.name == currency.name {
            purchasePrice = 474.85
            quantity = 120
        } else if CryptoCurrency.Ripple.name == currency.name {
            purchasePrice = 0.393455
            quantity = 30_000
        } else if CryptoCurrency.Dash.name == currency.name {
            purchasePrice = 245.33
            quantity = 10
        } else {
            purchasePrice = 0
            quantity = 0
        }
        return PortfolioAssetFactory.createAsset(for: currency, purchasePrice: purchasePrice, quantity: quantity)
    }
    
}


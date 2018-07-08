//
//  PortfolioAssetFactory.swift
//  CryptoCurrency
//
//  Created by Michael Aidoo on 2018-07-07.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation

struct PortfolioAssetFactory {
    static func createAsset(for currency: Currency, purchasePrice: Double, quantity: Int) -> Asset {
        return Asset(purchasePrice: purchasePrice, quantity: quantity, currency: currency)
    }
}


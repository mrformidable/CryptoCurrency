//
//  PortfolioViewModel.swift
//  CryptoCurrency
//
//  Created by Michael Aidoo on 2018-07-07.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation

struct PortfolioViewModel {
    
    let service: PortfolioAssetCreatable
    
    init(service: PortfolioAssetCreatable = PortfolioAssetGeneratorService()) {
        self.service = service
    }
    
    func fetchAsset(for curency: Currency) -> Asset {
        return service.createAsset(curency)
    }
}


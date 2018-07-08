//
//  PortfolioDataSource.swift
//  CryptoCurrency
//
//  Created by Michael Aidoo on 2018-07-07.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation
import UIKit

final class PortfolioDataSource: NSObject {
    var assets: [Asset] = []
}

extension PortfolioDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(PortfolioTableViewCell.self, for: indexPath)!
        let asset = assets[indexPath.row]
        let portfolioCellViewModel = PortfolioCellViewModel.init(asset: asset)
        cell.configureCell(for: portfolioCellViewModel)
        return cell
    }
    
}

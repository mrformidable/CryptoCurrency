//
//  CurrencyListDataSource.swift
//  CryptoCurrency
//
//  Created by Michael Aidoo on 2018-07-06.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation
import UIKit

final class CurrencyListDataSource: NSObject {
    var currencies: [Currency] = []
}

extension CurrencyListDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(CurrencyTableViewCell.self, for: indexPath)!
        let currency = currencies[indexPath.row]
        cell.configureCell(for: CurrencyCellViewModel(currency))
        return cell
    }
    
}

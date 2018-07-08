//
//  PortfolioDelegateSource.swift
//  CryptoCurrency
//
//  Created by Michael Aidoo on 2018-07-07.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation
import UIKit

final class PortfolioDelegateSource: NSObject {}

extension PortfolioDelegateSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
}

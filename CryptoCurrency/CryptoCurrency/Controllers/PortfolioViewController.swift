//
//  PortfolioViewController.swift
//  CryptoCurrency
//
//  Created by Michael Aidoo on 2018-07-07.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation
import UIKit

final class PortfolioViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let dataSource = PortfolioDataSource()
    private let delegateSource = PortfolioDelegateSource()
    
    var assets: [Asset] = []
    var currency: Currency?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.delegate = delegateSource
        tableView.register(.nib, type: PortfolioTableViewCell.self)
        
        // Remove seperator lines from tableView
        tableView.tableFooterView = UIView()
        
        let viewModel = PortfolioViewModel()
        if let currency = currency {
            let asset = viewModel.fetchAsset(for: currency)
            dataSource.assets.append(asset)
        }
        
        navigationItem.title = currency?.name
        navigationController?.navigationBar.tintColor = .black
    }
}

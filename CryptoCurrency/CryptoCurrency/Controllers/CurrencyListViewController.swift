//
//  CurrencyListViewController.swift
//  CryptoCurrency
//
//  Created by Michael Aidoo on 2018-07-06.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation
import UIKit

class CurrencyListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var loadingIndicatorView: LoadingIndicatorView = .fromNib()
    
    private let dataSource = CurrencyListDataSource()
    private let delegateSource = CurrencyListDelegateSource()
    private let viewModel = CurrencyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.delegate = delegateSource
        tableView.register(.nib, type: CurrencyTableViewCell.self)
        
        view.addSubview(loadingIndicatorView)
        loadingIndicatorView.center = view.center
        loadingIndicatorView.activityIndicator.startAnimating()
        
        viewModel.fetchCurrencies { [weak self](currencies) in
            if let currencies = currencies {
                self?.dataSource.currencies = currencies
                DispatchQueue.main.async {
                    self?.tableView.isHidden = false
                    self?.tableView.reloadData()
                    self?.loadingIndicatorView.activityIndicator.stopAnimating()
                    self?.loadingIndicatorView.removeFromSuperview()
                }
            }
        }
    }
    
}

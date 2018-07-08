//
//  CurrencyListViewController.swift
//  CryptoCurrency
//
//  Created by Michael Aidoo on 2018-07-06.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation
import UIKit

final class CurrencyListViewController: UIViewController {
    
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
        
        viewModel.fetchCurrencies { [weak self] (currencies) in
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
        addObservers()
    }
    
    @objc private func handleCurrencySelection(_ notification: Notification) {
        let indexPath = notification.object as? IndexPath
        performSegue(withIdentifier: Constants.SegueIdentifiers.showPortfolioController, sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.SegueIdentifiers.showPortfolioController {
            guard let portfolioViewController = segue.destination as? PortfolioViewController else {
                fatalError("Failed to instantiate PortfolioViewController")
            }
            if let indexPath = sender as? IndexPath {
                let currency = dataSource.currencies[indexPath.row]
                portfolioViewController.currency = currency
            }
        }
    }
    
}

// MARK:- Observers
extension CurrencyListViewController {
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleCurrencySelection(_:)), name: .handleCurrencySelection, object: nil)
    }
}


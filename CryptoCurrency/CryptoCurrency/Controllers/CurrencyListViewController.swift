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
    
    @IBOutlet weak var selectThemeButton: UIBarButtonItem!
    
    private lazy var loadingIndicatorView: LoadingIndicatorView = .fromNib()
    
    private let dataSource = CurrencyListDataSource()
    private let delegateSource = CurrencyListDelegateSource()
    private let viewModel = CurrencyViewModel()
    
    private let userDefaults = UserDefaults.standard
    private var isDarkTheme: Bool!
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        removeNavigationBarSeparator(false)
        setupThemeColor()
        addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }

    //MARK:- Actions
    @IBAction func selectThemeButtonTapped(_ sender: UIBarButtonItem) {
        isDarkTheme = userDefaults.value(forKey: "theme") as? Bool ?? false
        NotificationCenter.default.post(name: isDarkTheme ? .darkModeDisabled : .darkModeEnabled, object: nil)
        
        isDarkTheme = !isDarkTheme
        userDefaults.set(isDarkTheme, forKey: "theme")
        userDefaults.synchronize()
        tableView.reloadData()
    }
    
}

// MARK:- Segues
extension CurrencyListViewController {
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
        NotificationCenter.default.addObserver(self, selector: #selector(handleDarkModeSelection), name: .darkModeEnabled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleDayThemeSelection), name: .darkModeDisabled, object: nil)
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: .handleCurrencySelection, object: nil)
        NotificationCenter.default.removeObserver(self, name: .darkModeEnabled, object: nil)
        NotificationCenter.default.removeObserver(self, name: .darkModeDisabled, object: nil)
    }
}

//Note: ThemeColor change is a naive approach, only to illustrate and enhance UI, clearly this approach is not testable or reusable
// Ideally the view model should handle changes in state such as apperance
//MARK:- HandleThemes
extension CurrencyListViewController {
    private func setupThemeColor() {
        guard let isDarkTheme = userDefaults.value(forKey: "theme") as? Bool else {
            lightTheme()
            return
        }
        isDarkTheme ? darkTheme() : lightTheme()
    }
    
    func lightTheme() {
        selectThemeButton.image = UIImage(named: "moon_icon_dark")
        view.backgroundColor = UIColor.white
        tableView.backgroundColor = UIColor.white
        loadingIndicatorView.activityIndicator.color = .black
        loadingIndicatorView.messageLabel.textColor = .black
        loadingIndicatorView.backgroundColor = .white
        navigationController?.navigationBar.barStyle = .default
        navigationController?.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.barTintColor = .white
    }
    
    func darkTheme() {
        selectThemeButton.image = UIImage(named: "sun_icon_light")
        view.backgroundColor = UIColor.black
        loadingIndicatorView.activityIndicator.color = .white
        loadingIndicatorView.messageLabel.textColor = .white
        loadingIndicatorView.backgroundColor = .black
        tableView.backgroundColor = UIColor.black
        navigationController?.navigationBar.barStyle = .black
        navigationController?.view.backgroundColor = UIColor.black
        navigationController?.navigationBar.barTintColor = .black
    }
    
    @objc func handleDayThemeSelection() {
        lightTheme()
    }
    
    @objc func handleDarkModeSelection() {
        darkTheme()
    }
}

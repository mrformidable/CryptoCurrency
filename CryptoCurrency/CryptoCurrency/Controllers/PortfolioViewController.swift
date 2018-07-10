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
    
    private let userDefaults = UserDefaults.standard
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
        setupThemeColor()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
    
}

//MARK: - Obervers
extension PortfolioViewController {
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleDarkModeSelection), name: .darkModeEnabled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleDayThemeSelection), name: .darkModeDisabled, object: nil)
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: .darkModeEnabled, object: nil)
        NotificationCenter.default.removeObserver(self, name: .darkModeDisabled, object: nil)
    }
}

//MARK:- ThemeColor Appereance Change
extension PortfolioViewController {
    private func setupThemeColor() {
        guard let isDarkTheme = userDefaults.value(forKey: Constants.UserDefaultKeys.themeAppearanceKey) as? Bool else {
            lightTheme()
            return
        }
        isDarkTheme ? darkTheme() : lightTheme()
    }
    
    @objc func handleDayThemeSelection() {
        lightTheme()
    }
    
    @objc func handleDarkModeSelection() {
        darkTheme()
    }
    
    func lightTheme() {
        view.backgroundColor = UIColor.white
        tableView.backgroundColor = UIColor.white
        navigationController?.navigationBar.barStyle = .default
        navigationController?.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
        removeNavigationBarSeparator(true)
    }
    
    func darkTheme() {
        view.backgroundColor = UIColor.black
        tableView.backgroundColor = UIColor.black
        navigationController?.navigationBar.barStyle = .black
        navigationController?.view.backgroundColor = UIColor.black
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        removeNavigationBarSeparator(false)
    }
}

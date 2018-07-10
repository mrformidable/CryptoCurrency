//
//  CurrencyTableViewCell.swift
//  CryptoCurrency
//
//  Created by Michael Aidoo on 2018-07-06.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var separatorDot: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(for viewModel: CurrencyCellViewModel) {
        nameLabel.text = viewModel.name
        priceLabel.text = "$\(viewModel.marketPrice)"
        symbolLabel.text = viewModel.symbol
        handleThemeAppearance()
    }
    
    private func handleThemeAppearance() {
        let isDarkTheme = UserDefaults.standard.value(forKey: Constants.UserDefaultKeys.themeAppearanceKey) as? Bool ?? false
        isDarkTheme ? handleDarkTheme() : handleLightTheme()
    }
    
}

//MARK: - ThemeColor Appearance
private extension CurrencyTableViewCell {
    func handleDarkTheme() {
        nameLabel.textColor = .white
        priceLabel.textColor = .white
        separatorDot.textColor = .white
        backgroundColor = .black
    }
    
    func handleLightTheme() {
        nameLabel.textColor = .black
        priceLabel.textColor = .black
        separatorDot.textColor = .black
        backgroundColor = .white
    }
}

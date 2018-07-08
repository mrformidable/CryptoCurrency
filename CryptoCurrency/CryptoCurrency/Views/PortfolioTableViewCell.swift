//
//  PortfolioTableViewCell.swift
//  CryptoCurrency
//
//  Created by Michael Aidoo on 2018-07-07.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import UIKit

class PortfolioTableViewCell: UITableViewCell {
    
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var statisticsView: UIView!
    @IBOutlet weak var returnValueLabel: UILabel!
    @IBOutlet weak var returnLabel: UILabel!
    @IBOutlet weak var totalHoldingsLabel: UILabel!
    
    private var themeTextColor: UIColor = .black
    private var themeSubtitleTextColor: UIColor = .gray
    private var themePositiveReturnValueColor: UIColor = .rgb(0,143,0)
    private var themeProgressInnerTrackColor: UIColor = .rgb(76,76,255)
    private var themeProgressOuterTrackColor: UIColor = .lightGray
    private let animationDuration: TimeInterval = 2.0
    private let totalPortfolioValue: Double = 30_501.4 + 56_982 + 11_803.65 + 2_453.3
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(for viewModel: PortfolioCellViewModel) {
        handleThemeAppearance()
        
        quantityLabel.text = String(viewModel.quantity)
        
        let value = viewModel.purchasePrice * Double(viewModel.quantity)
        let roundedValue = "US$" + String(format: "%.2f", value)
        valueLabel.attributedText = setupValueLabel(roundedValue)
        
        quantityLabel.attributedText = setupQuantityLabel(String(viewModel.quantity), symbol: viewModel.currency.symbol)
        
        let portfolioReturn = calculatePortfolioReturn(viewModel)
        returnValueLabel.text = "US$" + String(format: "%.2f", portfolioReturn)
        returnValueLabel.textColor = portfolioReturn >= 0 ? themePositiveReturnValueColor : .red
        
        let marketValue = viewModel.currency.marketPrice * Double(viewModel.quantity)
        let percentage: Double = (marketValue / totalPortfolioValue)
        animatePortfolioStatistics(to: percentage)
    }
    
}

//MARK:- ThemeColor Apperance
extension PortfolioTableViewCell {
    private func handleThemeAppearance() {
        let isDarkTheme = UserDefaults.standard.value(forKey: "theme") as? Bool ?? false
        if isDarkTheme {
            themeTextColor = .white
            themeProgressOuterTrackColor = .rgb(45,45,45)
            themeSubtitleTextColor = .lightGray
            totalHoldingsLabel.textColor = .lightGray
            returnLabel.textColor = .white
            themePositiveReturnValueColor = .rgb(10,225,0)
            backgroundColor = .black
        } else {
            themeTextColor = .black
            themeProgressOuterTrackColor = .lightGray
            themeSubtitleTextColor = .gray
            totalHoldingsLabel.textColor = .gray
            returnLabel.textColor = .black
            themePositiveReturnValueColor = .rgb(0,143,0)
            backgroundColor = .white
        }
    }
}

extension PortfolioTableViewCell {
    func calculatePortfolioReturn(_ viewModel: PortfolioCellViewModel) -> Double {
        let purchaseCost = viewModel.purchasePrice * Double(viewModel.quantity)
        let marketValue = viewModel.currency.marketPrice * Double(viewModel.quantity)
        let portfolioReturn = marketValue - purchaseCost
        return portfolioReturn
    }
}

//MARK:- Setups
extension PortfolioTableViewCell {
    private func setupValueLabel(_ text: String) -> NSAttributedString {
        return createAttributedText(withTitle: text, subtitle: "Est. Value", titleFontSize: 18, descriptionFontSize: 14, titleColor: themeTextColor, descriptionColor: themeSubtitleTextColor)
    }
    private func setupQuantityLabel(_ text: String, symbol: String) -> NSAttributedString {
        return createAttributedText(withTitle: text, subtitle: symbol, titleFontSize: 18, descriptionFontSize: 14, titleColor: themeTextColor, descriptionColor: themeSubtitleTextColor)
    }
    
    private func animatePortfolioStatistics(to value: Double) {
        let xPosition = statisticsView.center.x + 6
        let yPosition = statisticsView.center.y
        let position = CGPoint(x: xPosition, y: yPosition)
        
        let progressBar = CircularProgressBar(radius: 35, position: position, innerTrackColor: themeProgressInnerTrackColor, outerTrackColor: themeProgressOuterTrackColor, lineWidth: 10, animationDuration: animationDuration)
        progressBar.animateProgress(to: value)
        progressBar.progressLabel.textColor = themeTextColor
        progressBar.progressLabel.count(from: 0, to: Float(value) * 100, duration: animationDuration)
        layer.addSublayer(progressBar)
    }
}

//MARK:- Helpers
extension PortfolioTableViewCell {
    func createAttributedText(withTitle title: String, subtitle: String, titleFontSize: CGFloat, descriptionFontSize: CGFloat, titleColor: UIColor, descriptionColor: UIColor) -> NSAttributedString {
        
        let attributedText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font:  UIFont.systemFont(ofSize: titleFontSize, weight: UIFont.Weight.heavy), NSAttributedString.Key.foregroundColor: titleColor])
        
        attributedText.append(NSAttributedString(string: "\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 4)]))
        
        attributedText.append(NSAttributedString(string: subtitle, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: descriptionFontSize), NSAttributedString.Key.foregroundColor: descriptionColor]))
        return attributedText
    }
    
}

//
//  PopularCurrencyTableViewCell.swift
//  CryptoCurrency
//
//  Created by Kaitlyn Barker on 6/15/18.
//  Copyright © 2018 Kaitlyn Barker. All rights reserved.
//

import UIKit

class PopularCurrencyTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var currencyImageView: UIImageView!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var conversionTypeLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    
    var currencyData: Datum? {
        didSet {
            self.updateViews()
        }
    }
    
    func updateViews() {
        guard let currencyData = self.currencyData else { return }
        let coinInfo = currencyData.coinInfo
        let conversionInfo = currencyData.conversionInfo
        
        guard let currencyImageURL = coinInfo.imageURL else { return }
        
        NetworkManager.shared.getCurrencyImage(url: currencyImageURL) { (image) in
            DispatchQueue.main.async {
                self.currencyImageView.image = image
                self.currencyNameLabel.text = coinInfo.fullName
                self.conversionTypeLabel.text = "\(coinInfo.name) -> \(conversionInfo.currencyTo.rawValue.uppercased())"
                
                // FIXME: - update the current price label when we figure out how to get the price.
                self.currentPriceLabel.text = "YOUR SOUL!!"
            }
        }
    }
}

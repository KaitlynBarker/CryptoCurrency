//
//  CurrencyDetailViewController.swift
//  CryptoCurrency
//
//  Created by Kaitlyn Barker on 6/18/18.
//  Copyright © 2018 Kaitlyn Barker. All rights reserved.
//

import UIKit

class CurrencyDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var conversionLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var openPriceLabel: UILabel!
    @IBOutlet weak var highestPriceLabel: UILabel!
    @IBOutlet weak var lowestPriceLabel: UILabel!
    
    var currencyData: Datum?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.populateView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateView() {
        guard let currencyData = self.currencyData else { return }
        
        NetworkManager.shared.getExchangeData(datum: currencyData) { (response) in
            guard let response = response else { return }
            let currencyInfo = response.data.coinInfo
            let aggregatedData = response.data.aggregatedData
            let exchanges = response.data.exchanges

            var points: [CGPoint] = []

            for exchange in exchanges {
                let price = Int(exchange.price)
                let robotTime = exchange.lastupdate
                let hour = Double(robotTime).getDateHour()
                let currentPoint = CGPoint(x: hour, y: price)
                points.append(currentPoint)
            }
            
            
            DispatchQueue.main.async {
                self.currencyNameLabel.text = "Name: \(currencyInfo.fullName)"
                self.conversionLabel.text = "\(currencyInfo.name) -> USD"
                self.currentPriceLabel.text = "Current Price: \(aggregatedData.price)"
                self.openPriceLabel.text = "Open Price: \(aggregatedData.open24Hour)"
                self.highestPriceLabel.text = "Highest Price: \(aggregatedData.high24Hour)"
                self.lowestPriceLabel.text = "Lowest Price: \(aggregatedData.low24Hour)"
            }
        }
    }
}

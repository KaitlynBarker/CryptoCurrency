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
    
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var conversionLabel: UILabel!
    @IBOutlet weak var currentPriceLabel: UILabel!
    @IBOutlet weak var openPriceLabel: UILabel!
    @IBOutlet weak var highestPriceLabel: UILabel!
    @IBOutlet weak var lowestPriceLabel: UILabel!
    
    var currencyData: Datum?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.graphView.backgroundColor = UIColor.darkGray
        self.graphView.lineColor = UIColor.customGreen
        self.graphView.circleColor = UIColor.clear
        self.graphView.axisColor = UIColor.white
        self.graphView.deltaX = 20
        self.graphView.deltaY = 40
        
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
//            let exchanges = response.data.exchanges
//
//            var points: [CGPoint] = []
//
//            for exchange in exchanges {
//                let price = Int(exchange.price)
//                let robotTime = exchange.lastupdate
//                let hour = Double(robotTime).getDateHour()
//                print(hour)
//                let day = Double(robotTime).getDateDay()
//                print(day)
//                let currentPoint = CGPoint(x: hour, y: price)
//                points.append(currentPoint)
//            }
            
            let f: (CGFloat) -> CGPoint = {
                let noiseY = (CGFloat(arc4random_uniform(2)) * 2 - 1) * CGFloat(arc4random_uniform(4))
                let noiseX = (CGFloat(arc4random_uniform(2)) * 2 - 1) * CGFloat(arc4random_uniform(4))
                let b: CGFloat = 5
                let y = 2 * $0 + b + noiseY
                
                return CGPoint(x: $0 + noiseY, y: y)
            }
            
            let xPoints = [Int](1..<20)
            let points = xPoints.map { f(CGFloat($0 * 10)) }
            
            self.graphView.plot(points)
            
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
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

//
//  CandleStickChart.swift
//  ChartCocoaPods
//
//  Created by José Fernando Márquez Cruz on 21/06/18.
//  Copyright © 2018 MCS. All rights reserved.
//

import UIKit
import Charts

class CandleStickChartViewController: DemoBaseViewController {
    
    @IBOutlet var chartView: CandleStickChartView!
    @IBOutlet var sliderX: UISlider!
    @IBOutlet var sliderY: UISlider!
    @IBOutlet var sliderTextFieldX: UITextField!
    @IBOutlet var sliderTextFieldY: UITextField!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var conversionLabel: UILabel!
    
    var currencyData: Datum?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        chartView.delegate = self
        
        chartView.chartDescription?.enabled = false
        
        chartView.dragEnabled = false
        chartView.setScaleEnabled(true)
        chartView.maxVisibleCount = 200
        chartView.pinchZoomEnabled = true
        
        chartView.legend.horizontalAlignment = .right
        chartView.legend.verticalAlignment = .top
        chartView.legend.orientation = .vertical
        chartView.legend.drawInside = false
        chartView.legend.font = UIFont(name: "HelveticaNeue-Light", size: 10)!
        
        chartView.leftAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 10)!
        chartView.leftAxis.spaceTop = 0.3
        chartView.leftAxis.spaceBottom = 0.3
        chartView.leftAxis.axisMinimum = 0
        
        chartView.rightAxis.enabled = false
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = UIFont(name: "HelveticaNeue-Light", size: 10)!
        
        sliderX.value = 0.10
        sliderY.value = 0.50
        slidersValueChanged(nil)
    }
    
    override func updateChartData() {
        self.setDataCount(Int(sliderX.value), range: UInt32(sliderY.value))
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        
        guard let currencyData = self.currencyData else { return }
        
        NetworkManager.shared.getExchangeData(datum: currencyData) { (response) in
            guard let response = response else { return }
            
            let currencyInfo = response.data.coinInfo
            let aggregatedData = response.data.aggregatedData
            let exchanges = response.data.exchanges
            
            var priceArray: [Double] = []
            
            for exchange in exchanges {
                let price = exchange.price
                priceArray.append(price)
            }
            
            guard let maxPrice = priceArray.max() else { return }
            
            DispatchQueue.main.async {
                self.currencyNameLabel.text = currencyInfo.fullName
                self.conversionLabel.text = "\(currencyInfo.name) -> USD"
                self.sliderX.maximumValue = Float(exchanges.count)
                self.sliderY.maximumValue = Float(maxPrice)
            }
            
            let yVals1 = (0..<count).map { (i) -> CandleChartDataEntry in
                let mult = range + 1
//                let val = Double(arc4random_uniform(40) + mult)
                let val = aggregatedData.price + Double(mult)
//                let high = Double(arc4random_uniform(9) + 8)
                let high = aggregatedData.high24Hour
//                let low = Double(arc4random_uniform(9) + 8)
                let low = aggregatedData.low24Hour
//                let open = Double(arc4random_uniform(6) + 1)
                let open = aggregatedData.open24Hour
//                let close = Double(arc4random_uniform(6) + 1)
                let close = aggregatedData.price
                let even = i % 2 == 0
                
                return CandleChartDataEntry(x: Double(i), shadowH: val + high, shadowL: val - low, open: even ? val + open : val - open, close: even ? val - close : val + close, icon: #imageLiteral(resourceName: "Icon-29"))
            }
            
            let set1 = CandleChartDataSet(values: yVals1, label: "Data Set")
            set1.axisDependency = .left
            set1.setColor(UIColor(white: 80/255, alpha: 1))
            set1.drawIconsEnabled = false
            set1.shadowColor = .darkGray
            set1.shadowWidth = 0.7
            set1.decreasingColor = .red
            set1.decreasingFilled = true
            set1.increasingColor = UIColor(red: 122/255, green: 242/255, blue: 84/255, alpha: 1)
            set1.increasingFilled = false
            set1.neutralColor = .blue
            
            let data = CandleChartData(dataSet: set1)
            self.chartView.data = data
        }
    }
    
    // MARK: - Actions
    @IBAction func slidersValueChanged(_ sender: Any?) {
        sliderTextFieldX.text = "\(Int(sliderX.value))"
        sliderTextFieldY.text = "\(Int(sliderY.value))"
        
        self.updateChartData()
    }}

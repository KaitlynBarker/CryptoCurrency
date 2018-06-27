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
        
        guard let currencyData = self.currencyData else { return }
        self.currencyNameLabel.text = currencyData.coinInfo.fullName
        self.conversionLabel.text = "\(currencyData.coinInfo.name) -> USD"
        
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
        
        NetworkManager.shared.getHistoryData(datum: currencyData) { (response) in
            guard let response = response else { return }
            
            let historyData = response.data
            
            for data in historyData {
//                let time = data.time
                let close = data.close
                let high = data.high
                let low = data.low
                let open = data.datumOpen
                
                let yVals1 = (0..<count).map { (i) -> CandleChartDataEntry in
                    let mult = range + 1
                    let val = Double(arc4random_uniform(40) + mult)
                    let high = high
                    let low = low
                    let open = open
                    let close = close
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
    }
    
    // MARK: - Actions
    @IBAction func slidersValueChanged(_ sender: Any?) {
        sliderTextFieldX.text = "\(Int(sliderX.value))"
        sliderTextFieldY.text = "\(Int(sliderY.value))"
        
        self.updateChartData()
    }}

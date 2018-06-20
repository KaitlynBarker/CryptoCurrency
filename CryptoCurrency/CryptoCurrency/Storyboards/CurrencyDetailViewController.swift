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
    
    var currencyData: Datum?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let currencyData = self.currencyData else { return }
        
        NetworkManager.shared.getExchangeData(datum: currencyData) { (response) in
            guard let response = response else { return }
            let printStatement = response.data.aggregatedData.type
            
            print(printStatement)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

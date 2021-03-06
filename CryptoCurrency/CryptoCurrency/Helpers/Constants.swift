//
//  Constants.swift
//  CryptoCurrency
//
//  Created by Kaitlyn Barker on 6/15/18.
//  Copyright © 2018 Kaitlyn Barker. All rights reserved.
//

import Foundation

class Constants {
    static let shared = Constants()
    
    // api keys
    
    let baseURL = "https://min-api.cryptocompare.com/data/"
    let baseImageURL = URL(string: "https://www.cryptocompare.com/")
    
    // network manager - strings for url sessions
    
    var histodayString: String { return "histoday" }
    var priceString: String { return "price" }
    var fromSymbolString: String { return "fsym" }
    var toSymbolString: String { return "tsym" }
    var limitString: String { return "limit" }
    var usdString: String { return "USD" }
    var requestMethod: String { return "GET" }
    
}

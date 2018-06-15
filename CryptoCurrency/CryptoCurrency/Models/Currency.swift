//
//  Currency.swift
//  CryptoCurrency
//
//  Created by Kaitlyn Barker on 6/15/18.
//  Copyright © 2018 Kaitlyn Barker. All rights reserved.
//

import Foundation

struct Currency: Codable {
    let name: String
    let id: String
    let url: String
    let imageURL: String
    let symbol: String
    let coinName: String
    let fullName: String
    let algorithm: String
    let proofType: String
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case id = "Id"
        case url = "Url"
        case imageURL = "ImageUrl"
        case symbol = "Symbol"
        case coinName = "CoinName"
        case fullName = "FullName"
        case algorithm = "Algorithm"
        case proofType = "ProofType"
    }
}

/*
 Other Properties API Has:
 "FullyPremined": "0",
 "TotalCoinSupply": "21000000",
 "PreMinedValue": "N/A",
 "TotalCoinsFreeFloat": "N/A",
 "SortOrder": "1",
 "Sponsored": false,
 "IsTrading": true
*/

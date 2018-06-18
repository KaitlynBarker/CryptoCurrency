//
//  JSONResponse.swift
//  CryptoCurrency
//
//  Created by Kaitlyn Barker on 6/15/18.
//  Copyright © 2018 Kaitlyn Barker. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct Welcome: Codable {
    let message: String
    let type: Int
    let sponsoredData, data: [Datum]
    
    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case type = "Type"
        case sponsoredData = "SponsoredData"
        case data = "Data"
    }
}

struct Datum: Codable {
    let coinInfo: CoinInfo
    let conversionInfo: ConversionInfo
    
    enum CodingKeys: String, CodingKey {
        case coinInfo = "CoinInfo"
        case conversionInfo = "ConversionInfo"
    }
}

struct CoinInfo: Codable {
    let id, name, fullName, coinInfoInternal: String
    let url, algorithm, proofType: String
    let netHashesPerSecond: Double
    let blockNumber, blockTime: Int
    let blockReward: Double
    let type: Int
    let documentType: DocumentType
    private var _imageURL: String
    var imageURL: URL? {
        return Constants.shared.baseImageURL?.appendingPathComponent(_imageURL)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case fullName = "FullName"
        case coinInfoInternal = "Internal"
        case _imageURL = "ImageUrl"
        case url = "Url"
        case algorithm = "Algorithm"
        case proofType = "ProofType"
        case netHashesPerSecond = "NetHashesPerSecond"
        case blockNumber = "BlockNumber"
        case blockTime = "BlockTime"
        case blockReward = "BlockReward"
        case type = "Type"
        case documentType = "DocumentType"
    }
}

/*
 private var _icon: String
 var icon: URL? {
 return URL(string: "http://openweathermap.org/img/w/\(_icon).png")
 }
*/

enum DocumentType: String, Codable {
    case webpagecoinp = "Webpagecoinp"
}

struct ConversionInfo: Codable {
    let conversion: Conversion
    let conversionSymbol: ConversionSymbol
    let currencyFrom: String
    let currencyTo: CurrencyTo
    let market: Market
    let supply, totalVolume24H: Double
    let subBase: SubBase
    let subsNeeded, raw: [String]
    
    enum CodingKeys: String, CodingKey {
        case conversion = "Conversion"
        case conversionSymbol = "ConversionSymbol"
        case currencyFrom = "CurrencyFrom"
        case currencyTo = "CurrencyTo"
        case market = "Market"
        case supply = "Supply"
        case totalVolume24H = "TotalVolume24H"
        case subBase = "SubBase"
        case subsNeeded = "SubsNeeded"
        case raw = "RAW"
    }
}

enum Conversion: String, Codable {
    case direct = "direct"
    case multiply = "multiply"
}

enum ConversionSymbol: String, Codable {
    case empty = ""
    case eth = "ETH"
}

enum CurrencyTo: String, Codable {
    case usd = "USD"
}

enum Market: String, Codable {
    case cccagg = "CCCAGG"
}

enum SubBase: String, Codable {
    case the5 = "5~"
}


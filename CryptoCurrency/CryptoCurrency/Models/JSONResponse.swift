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

struct ExchangeResponse: Codable {
    let response, message: String
    let data: DataClass
    
    enum CodingKeys: String, CodingKey {
        case response = "Response"
        case message = "Message"
        case data = "Data"
    }
}

struct DataClass: Codable {
    let coinInfo: CoinInfo
    let aggregatedData: AggregatedData
    let exchanges: [AggregatedData]
    
    enum CodingKeys: String, CodingKey {
        case coinInfo = "CoinInfo"
        case aggregatedData = "AggregatedData"
        case exchanges = "Exchanges"
    }
}

struct AggregatedData: Codable {
    let type, market, fromsymbol, tosymbol: String
    let flags: String
    let price: Double
    let lastupdate: Int
    let lastvolume, lastvolumeto: Double
    let lasttradeid: String
    let volumeday, volumedayto: Double?
    let volume24Hour, volume24Hourto: Double
    let openday, highday, lowday: Double?
    let open24Hour, high24Hour, low24Hour: Double
    let lastmarket: String?
    let change24Hour, changepct24Hour, changeday, changepctday: Double
    let supply: Int?
    let mktcap, totalvolume24H, totalvolume24Hto: Double?
    
    enum CodingKeys: String, CodingKey {
        case type = "TYPE"
        case market = "MARKET"
        case fromsymbol = "FROMSYMBOL"
        case tosymbol = "TOSYMBOL"
        case flags = "FLAGS"
        case price = "PRICE"
        case lastupdate = "LASTUPDATE"
        case lastvolume = "LASTVOLUME"
        case lastvolumeto = "LASTVOLUMETO"
        case lasttradeid = "LASTTRADEID"
        case volumeday = "VOLUMEDAY"
        case volumedayto = "VOLUMEDAYTO"
        case volume24Hour = "VOLUME24HOUR"
        case volume24Hourto = "VOLUME24HOURTO"
        case openday = "OPENDAY"
        case highday = "HIGHDAY"
        case lowday = "LOWDAY"
        case open24Hour = "OPEN24HOUR"
        case high24Hour = "HIGH24HOUR"
        case low24Hour = "LOW24HOUR"
        case lastmarket = "LASTMARKET"
        case change24Hour = "CHANGE24HOUR"
        case changepct24Hour = "CHANGEPCT24HOUR"
        case changeday = "CHANGEDAY"
        case changepctday = "CHANGEPCTDAY"
        case supply = "SUPPLY"
        case mktcap = "MKTCAP"
        case totalvolume24H = "TOTALVOLUME24H"
        case totalvolume24Hto = "TOTALVOLUME24HTO"
    }
}

struct ListResponse: Codable {
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
//    let type: Int
//    let documentType: DocumentType
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
//        case type = "Type"
//        case documentType = "DocumentType"
    }
}


//enum DocumentType: String, Codable {
//    case webpagecoinp = "Webpagecoinp"
//}

struct ConversionInfo: Codable {
    let conversion: Conversion
    let conversionSymbol: String
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

enum CurrencyTo: String, Codable {
    case usd = "USD"
}

enum Market: String, Codable {
    case cccagg = "CCCAGG"
}

enum SubBase: String, Codable {
    case the5 = "5~"
}


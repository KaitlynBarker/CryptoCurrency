//
//  NetworkManager.swift
//  CryptoCurrency
//
//  Created by Kaitlyn Barker on 6/15/18.
//  Copyright © 2018 Kaitlyn Barker. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    func getPopularCurrencyInfo(completion: @escaping (ListResponse?) -> Void) {
        guard let baseURL = URL(string: "\(Constants.shared.baseURL)top") else { completion(nil); return }
        let url = baseURL.appendingPathComponent("totalvol")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let limitQueryItem = URLQueryItem(name: Constants.shared.limitString, value: "10")
        let symbolQueryItem = URLQueryItem(name: Constants.shared.toSymbolString, value: Constants.shared.usdString)
        
        components?.queryItems = [limitQueryItem, symbolQueryItem]
        
        guard let requestURL = components?.url else { completion(nil); return }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = Constants.shared.requestMethod
        request.httpBody = nil
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            if let error = error { debugPrint("Error found!", error.localizedDescription); completion(nil); return }
            
            guard let data = data, let response = urlResponse as? HTTPURLResponse else { completion(nil); return }
            guard (200...299).contains(response.statusCode) else { completion(nil); return }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(ListResponse.self, from: data)
                
                completion(result)
            } catch let parseError {
                debugPrint("Error parsing popular currency JSON.", parseError.localizedDescription)
                completion(nil)
                return
            }
        }
        dataTask.resume()
    }
    
    func getHistoryData(datum: Datum, completion: @escaping (HistoryResponse?) -> Void) {
        let coinName = datum.coinInfo.name
        
        guard let baseURL = URL(string: Constants.shared.baseURL) else { completion(nil); return }
        let url = baseURL.appendingPathComponent(Constants.shared.histodayString)
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let fromSymbolQueryItem = URLQueryItem(name: Constants.shared.fromSymbolString, value: coinName)
        let toSymbolQueryItem = URLQueryItem(name: Constants.shared.toSymbolString, value: Constants.shared.usdString)
        let limitQueryItem = URLQueryItem(name: Constants.shared.limitString, value: "15")
        
        components?.queryItems = [fromSymbolQueryItem, toSymbolQueryItem, limitQueryItem]
        
        guard let requestURL = components?.url else { completion(nil); return }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = Constants.shared.requestMethod
        request.httpBody = nil
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            if let error = error { debugPrint("error in data task", error.localizedDescription); completion(nil); return }
            guard let data = data, let response = urlResponse as? HTTPURLResponse else { completion(nil); return }
            guard (200...299).contains(response.statusCode) else { completion(nil); return }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(HistoryResponse.self, from: data)
                completion(result)
            } catch let parseError {
                debugPrint("error found parsing history json", parseError.localizedDescription)
                completion(nil)
                return
            }
        }
        dataTask.resume()
    }
    // histoday?fsym=BTC&tsym=USD&limit=15
    
    func getCurrentPrice(datum: Datum, completion: @escaping (CurrentPriceResponse?) -> Void) {
        let coinName = datum.coinInfo.name
        
        guard let baseURL = URL(string: Constants.shared.baseURL) else { completion(nil); return }
        let url = baseURL.appendingPathComponent(Constants.shared.priceString)
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let fromSymbolQueryItem = URLQueryItem(name: Constants.shared.fromSymbolString, value: coinName)
        let toSymbolsQueryItem = URLQueryItem(name: "tsyms", value: Constants.shared.usdString)
        
        components?.queryItems = [fromSymbolQueryItem, toSymbolsQueryItem]
        
        guard let requestURL = components?.url else { completion(nil); return }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = Constants.shared.requestMethod
        request.httpBody = nil
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            if let error = error { debugPrint("error in data task", error.localizedDescription); completion(nil); return }
            guard let data = data, let response = urlResponse as? HTTPURLResponse else { completion(nil); return }
            guard (200...299).contains(response.statusCode) else { completion(nil); return }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(CurrentPriceResponse.self, from: data)
                completion(result)
            } catch let parseError {
                debugPrint("error found parsing current price json", parseError.localizedDescription)
                completion(nil)
                return
            }
        }
        dataTask.resume()
    }
    // price?fsym=BTC&tsyms=USD
    
    func getCurrencyImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = Constants.shared.requestMethod
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error { debugPrint("Error getting image.", error.localizedDescription); completion(nil); return }
            
            guard let data = data, let image = UIImage(data: data) else { completion(nil); return }
            completion(image)
        }
        dataTask.resume()
    }
}

// top/totalvol?limit=10&tsym=USD
// https://min-api.cryptocompare.com/data/top/totalvol?limit=10&tsym=USD - checks out

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
        guard let baseURL = URL(string: Constants.shared.baseURL) else { completion(nil); return }
        let url = baseURL.appendingPathComponent("totalvol")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let limitQueryItem = URLQueryItem(name: "limit", value: "10")
        let symbolQueryItem = URLQueryItem(name: "tsym", value: "USD")
        
        components?.queryItems = [limitQueryItem, symbolQueryItem]
        
        guard let requestURL = components?.url else { completion(nil); return }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
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
    
    func getExchangeData(datum: Datum, completion: @escaping (ExchangeResponse?) -> Void) {
        // take the datum and get the coin info.Internal or Name
        let coinName = datum.coinInfo.name
        // use the name as the fsym in the url to pull the information for the exchange response.
        guard let baseURL = URL(string: "\(Constants.shared.baseURL)exchanges") else { completion(nil); return }
        let url = baseURL.appendingPathComponent("full")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let fromSymbolQueryItem = URLQueryItem(name: "fsym", value: coinName)
        let toSymbolQueryItem = URLQueryItem(name: "tsym", value: "USD")
        
        components?.queryItems = [fromSymbolQueryItem, toSymbolQueryItem]
        
        guard let requestURL = components?.url else { completion(nil); return }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            if let error = error { debugPrint("error in data task", error.localizedDescription); completion(nil); return }
            guard let data = data, let response = urlResponse as? HTTPURLResponse else { completion(nil); return }
            guard (200...299).contains(response.statusCode) else { completion(nil); return }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(ExchangeResponse.self, from: data)
                print("YAY IT WORKED")
                completion(result)
            } catch let parseError {
                debugPrint("error found parsing exchange json", parseError.localizedDescription)
                completion(nil)
                return
            }
        }
        dataTask.resume()
    }
    // baseURL-appendingPathComponenet-exchanges/full?fsym=BTC&tsym=USD
    // from symbol needs to match Internal or Name
    
    func getCurrencyImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
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

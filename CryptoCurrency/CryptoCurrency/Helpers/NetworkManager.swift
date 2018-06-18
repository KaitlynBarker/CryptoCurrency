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
    
    func getPopularCurrencyInfo(completion: @escaping (Welcome?) -> Void) {
        guard let baseURL = URL(string: "\(Constants.shared.baseURL)top/") else { completion(nil); return }
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
                let result = try decoder.decode(Welcome.self, from: data)
                
                completion(result)
            } catch let parseError {
                debugPrint("Error parsing popular currency JSON.", parseError.localizedDescription)
                completion(nil)
                return
            }
        }
        dataTask.resume()
    }
    
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
// https://min-api.cryptocompare.com/data/top/totalvol?limit=10&tsym=USD
// https://min-api.cryptocompare.com/data/top/totalvol?limit=10&tsym=USD

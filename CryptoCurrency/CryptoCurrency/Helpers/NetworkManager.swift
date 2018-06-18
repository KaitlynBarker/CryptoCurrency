//
//  NetworkManager.swift
//  CryptoCurrency
//
//  Created by Kaitlyn Barker on 6/15/18.
//  Copyright © 2018 Kaitlyn Barker. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func getPopularCurrencyInfo(completion: @escaping (Welcome?) -> Void) {
        guard let baseURL = Constants.shared.baseURL else { completion(nil); return }
        let url = baseURL.appendingPathComponent("top")
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        
        let totalVolQueryItem = URLQueryItem(name: "totalvol", value: nil)
        let limitQueryItem = URLQueryItem(name: "limit", value: "10")
        let symbolQueryItem = URLQueryItem(name: "tsym", value: "USD")
        
        components?.queryItems = [totalVolQueryItem, limitQueryItem, symbolQueryItem]
        
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
}

// top/totalvol?limit=10&tsym=USD

//
//  Conversions.swift
//  CryptoCurrency
//
//  Created by Kaitlyn Barker on 6/21/18.
//  Copyright © 2018 Kaitlyn Barker. All rights reserved.
//

import Foundation

extension Double {
    func getDateHour() -> Int {
        let date = Date(timeIntervalSince1970: self)
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        return hour
    }
    
    func getDateDay() -> Int {
        let date = Date(timeIntervalSince1970: self)
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        return day
    }
}

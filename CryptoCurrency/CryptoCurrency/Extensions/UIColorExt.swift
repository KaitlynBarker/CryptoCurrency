//
//  UIColorExt.swift
//  CryptoCurrency
//
//  Created by Kaitlyn Barker on 6/19/18.
//  Copyright © 2018 Kaitlyn Barker. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class var customGreen: UIColor {
        return UIColor(hex: "6DC995")
    }
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(red: CGFloat(r) / 0xff, green: CGFloat(g) / 0xff, blue: CGFloat(b) / 0xff, alpha: 1)
    }
}

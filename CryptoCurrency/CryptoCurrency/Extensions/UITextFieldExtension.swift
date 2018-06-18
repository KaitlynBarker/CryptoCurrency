//
//  UITextFieldExtension.swift
//  CryptoCurrency
//
//  Created by José Fernando Márquez Cruz on 15/06/18.
//  Copyright © 2018 Kaitlyn Barker. All rights reserved.
//

import UIKit


extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

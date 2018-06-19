//
//  TabBarController.swift
//  CryptoCurrency
//
//  Created by Kaitlyn Barker on 6/15/18.
//  Copyright © 2018 Kaitlyn Barker. All rights reserved.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController {
    
    // FIXME: - connect tab bar controller storyboard class to this.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customTabBar()
        
        let arrayOfImageNameForSelectedState = ["selectedCoin"]
        let arrayOfImageNameForUnselectedState = ["coin"]
        
        if let count = self.tabBar.items?.count {
            for i in 0...(count-1) {
                let imageNameForSelectedState = arrayOfImageNameForSelectedState[i]
                let imageNameForUnselectedState = arrayOfImageNameForUnselectedState[i]
                
                self.tabBar.items?[i].selectedImage = UIImage(named: imageNameForSelectedState)?.withRenderingMode(.alwaysOriginal)
                self.tabBar.items?[i].image = UIImage(named: imageNameForUnselectedState)?.withRenderingMode(.alwaysOriginal)
            }
        }
        
        let selectedColor = UIColor.customGreen
        let unselectedColor = UIColor.black
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: selectedColor], for: .selected)
    }
    
    func customTabBar() {
        let pcStoryboard = UIStoryboard(name: "PopularCurrency", bundle: nil)
        let popularListNav = pcStoryboard.instantiateViewController(withIdentifier: "PopularCurrency")
        let popListNavController = UINavigationController(rootViewController: popularListNav)
        popularListNav.title = "Popular Currencies"
        popularListNav.tabBarItem.image = #imageLiteral(resourceName: "coin")
        popularListNav.tabBarItem.selectedImage = #imageLiteral(resourceName: "selectedCoin")
        
        viewControllers = [popListNavController]
    }
}

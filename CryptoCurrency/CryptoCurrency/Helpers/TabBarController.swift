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
    }
    
    func customTabBar() {
        
    }
}

/*
 class CustomTabBarController: UITabBarController {
 override func viewDidLoad() {
 super.viewDidLoad()
 
 customTabBar()
 
 let arrayOfImageNameForSelectedState = ["selectedSearch", "selectedHeart", "selectedTask"]
 let arrayOfImageNameForUnselectedState = ["searchIcon", "heartIcon", "task"]
 
 if let count = self.tabBar.items?.count {
 for i in 0...(count-1) {
 let imageNameForSelectedState = arrayOfImageNameForSelectedState[i]
 let imageNameForUnselectedState = arrayOfImageNameForUnselectedState[i]
 
 self.tabBar.items?[i].selectedImage = UIImage(named: imageNameForSelectedState)?.withRenderingMode(.alwaysOriginal)
 self.tabBar.items?[i].image = UIImage(named: imageNameForUnselectedState)?.withRenderingMode(.alwaysOriginal)
 }
 }
 
 let selectedColor = UIColor.candyAppleRed
 let unselectedColor = UIColor.customMaroon
 
 UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: unselectedColor], for: .normal)
 UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor: selectedColor], for: .selected)
 }
 
 func customTabBar() {
 
 let storyboard = UIStoryboard(name: "Main", bundle: nil)
 let searchNav = storyboard.instantiateViewController(withIdentifier: "RestaurantSearch")
 let searchNavController = UINavigationController(rootViewController: searchNav)
 searchNav.title = "Search"
 searchNav.tabBarItem.image = #imageLiteral(resourceName: "searchIcon")
 searchNav.tabBarItem.selectedImage = #imageLiteral(resourceName: "selectedSearch")
 
 let favsNav = storyboard.instantiateViewController(withIdentifier: "FavoritesList")
 let favsNavController = UINavigationController(rootViewController: favsNav)
 favsNav.title = "Favorites"
 favsNav.tabBarItem.image = #imageLiteral(resourceName: "heart")
 favsNav.tabBarItem.selectedImage = #imageLiteral(resourceName: "selectedHeart")
 
 let toTryNav = storyboard.instantiateViewController(withIdentifier: "ToTrysList")
 let toTryNavController = UINavigationController(rootViewController: toTryNav)
 toTryNav.title = "To Try"
 toTryNav.tabBarItem.image = #imageLiteral(resourceName: "taskList")
 toTryNav.tabBarItem.selectedImage = #imageLiteral(resourceName: "selectedTask")
 
 viewControllers = [searchNavController, favsNavController, toTryNavController]
 }
 }
*/

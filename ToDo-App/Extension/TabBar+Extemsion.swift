//
//  TabBar+Extemsion.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/24/21.
//

import UIKit

extension UITabBar {
    func addBadge(index:Int) {
        if let tabItems = self.items {
            let tabItem = tabItems[index]
            
            if let badgeValue = tabItem.badgeValue,
               let value = Int(badgeValue) {
                tabItem.badgeValue = String(value + 1)
            } else {
                tabItem.badgeValue = "1"
            }
        }
    }
    func removeBadge(index:Int) {
        if let tabItems = self.items {
            let tabItem = tabItems[index]
            tabItem.badgeValue = nil
        }
    }
    
}

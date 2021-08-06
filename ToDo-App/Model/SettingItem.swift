//
//  SettingItem.swift
//  ToDo-App
//
//  Created by Dion Dula on 8/5/21.
//

import UIKit

struct SettingItem {
    var name : String
    var image : UIImage
    var settingType : SettingType = .none
}

enum SettingType {
    case none
    case normal
    case switch_
    case textField
}

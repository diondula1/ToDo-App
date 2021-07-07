//
//  test.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/15/21.
//

import UIKit

struct NotificationResponse : Decodable{
    var id : String
    var messageDescription : String
    var project: Project
    var date: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case messageDescription = "Description"
        case project = "Project"
        case date = "CreatedDate"
    }
    
    
    
}


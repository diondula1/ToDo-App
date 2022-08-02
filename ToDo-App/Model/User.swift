//
//  User.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/13/21.
//

import Foundation

struct User: Codable, Equatable{
    var id : String
    var username : String
    var token : String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case username = "Username"
        case token = "token"
    }
    
    static func ==(lhs: User, rhs: User) -> Bool {
        return true
    }
}

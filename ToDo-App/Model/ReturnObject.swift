//
//  ReturnObject.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/13/21.
//

import UIKit

struct ReturnObject<Element : Decodable> : Decodable {
    var success : Bool
    var message : String
    var status : Int
    var data : Element?
}

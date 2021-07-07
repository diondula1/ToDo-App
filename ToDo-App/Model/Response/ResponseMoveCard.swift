//
//  RequestMoveCard.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/19/21.
//

import Foundation

struct ResponseMoveCard : Encodable , Decodable{
    var newCard : Card
    var oldCard: Card
}

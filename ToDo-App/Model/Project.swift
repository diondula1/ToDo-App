//
//  Project.swift
//  ToDo-App
//
//  Created by Dion Dula on 4/14/21.
//

import Foundation
import MobileCoreServices

class Project: Decodable {
    var id : String
    var title : String
    var categories: [Category]?
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title = "Title"
        case categories = "Categories"
    }
    
    init(id: String,title: String) {
        self.id = id
        self.title = title
    }
}


class Category: Decodable , Encodable {
    var id : String
    var title : String
    var cards: [Card]
    
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title = "Title"
        case cards = "Cards"
        
    }
    
    init(id: String,title: String) {
        self.id = id
        self.title = title
        self.cards = []
        
    }
}



class Card: NSObject, Decodable, Encodable{
    
    public var id : String
    public var title : String
    public var categoryId: String
    
    var cardDescription: String?
    var color : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title = "Title"
        case categoryId = "Category"
        case cardDescription = "Description"
        case color = "Color"
        
    }
    
    init(id: String,title: String,categoryId: String) {
        self.id = id
        self.title = title
        self.categoryId = categoryId
        self.cardDescription = ""
        self.color = ""
    }
    
}

public let geocacheTypeId = "com.razeware.geocache"

extension Card: NSItemProviderWriting {
    public static var writableTypeIdentifiersForItemProvider: [String] {
        return [(kUTTypeData as String)]
    }
    
    public func loadData(
        withTypeIdentifier typeIdentifier: String,
        forItemProviderCompletionHandler completionHandler:
            @escaping (Data?, Error?) -> Void) -> Progress? {
        let progress = Progress(totalUnitCount: 100)
        do {
            //Here the object is encoded to a JSON data object and sent to the completion handler
            let data = try JSONEncoder().encode(self)
            progress.completedUnitCount = 100
            completionHandler(data, nil)
        } catch {
            completionHandler(nil, error)
        }
        return progress
    }
}


extension Card: NSItemProviderReading {
    static var readableTypeIdentifiersForItemProvider: [String] {
        return [(kUTTypeData) as String]
    }
    
    static func object(withItemProviderData data: Data, typeIdentifier: String) throws -> Self {
        let decoder = JSONDecoder()
        do {
            //Here we decode the object back to it's class representation and return it
            let subject = try decoder.decode(self, from: data)
            return subject
        } catch {
            fatalError()
            
        }
    }
    
    
}

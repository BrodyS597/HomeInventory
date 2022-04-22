//
//  Collection.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/11/22.
//

import Foundation

class Collection {
    
    // MARK: -Keys
    enum Key {
        static let collectionType = "Collections"
        static let name = "name"
        static let items = "items"
        static let imageURL = "imageURL"
        static let value = "value"
        static let uuid = "uuid"
    }
    
    var imagePath: String {
        "images/\(self.uuid)"
    }
    
    // MARK: -Properties
    var name: String
    var items: [Item]
    var imageURL: URL?
    var uuid: String
    var value: Double {
        var totalValue = 0.0
        for item in items {
            totalValue += item.valuePrice
        }
        return totalValue
    }
    
    var CollectionData: [String: Any] {
        [Key.name : self.name,
         Key.items : self.items,
         Key.imageURL : self.imageURL,
         Key.value : self.value,
         Key.uuid : self.uuid]
    }

    // MARK: -INIT
    init(name: String, items: [Item], imageURL: URL? = nil, uuid: String = UUID().uuidString) {
        self.name = name
        self.items = items
        self.imageURL = imageURL
        self.uuid = uuid
    }
    
    init?(fromDictionary dictionary: [String: Any]) {
        guard let name = dictionary[Key.name] as? String,
              let items = dictionary[Key.items] as? [Item],
              let uuid = dictionary[Key.uuid] as? String
        else { return nil }
        
        self.name = name
        self.items = items
        self.uuid = uuid
        
        guard let imageURLString = dictionary[Key.imageURL] as? String else { return }
        let imageURL = URL(string: imageURLString)
        self.imageURL = imageURL
    }
}

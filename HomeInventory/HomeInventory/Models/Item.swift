//
//  Item.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/15/22.
//

import Foundation

class Item {
    
    // MARK: -Keys
    enum Key {
        static let collectionType = "Item"
        static let itemName = "itemName"
        static let itemPhotoURL = "itemPhotoURL"
        static let model = "model"
        static let serialNumber = "serialNumber"
        static let purchasePrice = "purchasePrice"
        static let valuePrice = "valuePrice"
        static let purchaseDate = "purchaseDate"
        static let itemCategory = "itemCategory"
        static let notes = "notes"
        static let uuid = "uuid"
    }
    
    var imagePath: String {
        "images\(self.uuid)"
    }
    
    // MARK: -Properties
    var itemName: String
    var itemPhotoURL: URL?
    var model: String
    var serialNumber: String
    var purchasePrice: Double
    var valuePrice: Double
    var purchaseDate: String
    var itemCategory: String
    var notes: String
    var uuid: String
    
    var itemData: [String: Any] {
        [Key.itemName : self.itemName,
         Key.itemPhotoURL : self.itemPhotoURL,
         Key.model : self.model,
         Key.serialNumber : self.serialNumber,
         Key.purchasePrice : self.purchasePrice,
         Key.valuePrice : self.valuePrice,
         Key.purchaseDate : self.purchaseDate,
         Key.itemCategory : self.itemCategory,
         Key.notes : self.notes,
         Key.uuid : self.uuid
        ]
    }

    // MARK: -INIT
    init(itemName: String, itemPhotoURL: URL? = nil, model: String, serialNumber: String, purchasePrice: Double, valuePrice: Double, purchaseDate: String, itemCategory: String, notes: String, uuid: String = UUID().uuidString) {
        self.itemName = itemName
        self.itemPhotoURL = itemPhotoURL
        self.model = model
        self.serialNumber = serialNumber
        self.purchasePrice = purchasePrice
        self.valuePrice = valuePrice
        self.purchaseDate = purchaseDate
        self.itemCategory = itemCategory
        self.notes = notes
        self.uuid = uuid
    }
    
    init?(fromDictionary dictionary: [String: Any]) {
        guard let itemName = dictionary[Key.itemName] as? String,
              let model = dictionary[Key.model] as? String,
              let serialNumber = dictionary[Key.serialNumber] as? String,
              let purchasePrice = dictionary[Key.purchasePrice] as? Double,
              let valuePrice = dictionary[Key.valuePrice] as? Double,
              let purchaseDate = dictionary[Key.purchaseDate] as? String,
              let itemCategory = dictionary[Key.itemCategory] as? String,
              let notes = dictionary[Key.notes] as? String,
              let uuid = dictionary[Key.uuid] as? String
        else { return nil }
        
        self.itemName = itemName
        self.model = model
        self.serialNumber = serialNumber
        self.purchasePrice = purchasePrice
        self.valuePrice = valuePrice
        self.purchaseDate = purchaseDate
        self.itemCategory = itemCategory
        self.notes = notes
        self.uuid = uuid
        
        guard let imageURLString = dictionary[Key.itemPhotoURL] as? String else { return }
        let imageURL = URL(string: imageURLString)
        self.itemPhotoURL = imageURL
    }
}

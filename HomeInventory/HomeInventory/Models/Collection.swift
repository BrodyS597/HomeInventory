//
//  Collection.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/11/22.
//

import Foundation

class Collection {
    // MARK: -Properties
    var name: String
    var items: [Item]

    // MARK: -INIT
    init(name: String, items: [Item]) {
        self.name = name
        self.items = items
    }
}

class Item {
    
    // MARK: -Properties
    var itemName: String
    var itemPhotoURL: URL?
    var model: String
    var serialNumber: String
    var purchasePrice: Double
    var valuePrice: Double
    var purchaseDate: Date
    var itemCategory: String
    var notes: String

    // MARK: -INIT
    init(itemName: String, itemPhotoURL: URL? = nil, model: String, serialNumber: String, purchasePrice: Double, valuePrice: Double, purchaseDate: Date = Date (), itemCategory: String, notes: String) {
        self.itemName = itemName
        self.itemPhotoURL = itemPhotoURL
        self.model = model
        self.serialNumber = serialNumber
        self.purchasePrice = purchasePrice
        self.valuePrice = valuePrice
        self.purchaseDate = purchaseDate
        self.itemCategory = itemCategory
        self.notes = notes
    }
}

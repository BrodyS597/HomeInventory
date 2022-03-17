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
    var value: Double
    var items: [Item]

    // MARK: -INIT
    init(name: String, value: Double, items: [Item]) {
        self.name = name
        self.value = value
        self.items = items
    }
}

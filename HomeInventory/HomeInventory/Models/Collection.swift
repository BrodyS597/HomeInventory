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
    var value: Double {
        var totalValue = 0.0
        for item in items {
            totalValue += item.valuePrice
        }
        return totalValue
    }

    // MARK: -INIT
    init(name: String, items: [Item]) {
        self.name = name
        self.items = items
    }
}

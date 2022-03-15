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



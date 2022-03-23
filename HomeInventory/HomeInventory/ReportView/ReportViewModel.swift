//
//  ReportViewModel.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/14/22.
//

import Foundation

class ReportViewModel {
    
    // MARK: -Properties
    var collection: [Collection]?
    //    var collections: [Collection] = [ Collection(name: "testColl1", items: [Item(itemName: "testTV", itemPhotoURL: nil, model: "testmodel#", serialNumber: "testSerial#", purchasePrice: 23.00, valuePrice: 23.00, purchaseDate: "01/01/01", itemCategory: "testCategory", notes: "These are test notes"), Item(itemName: "testItem2", itemPhotoURL: nil, model: "123M", serialNumber: "456789", purchasePrice: 90.00, valuePrice: 90.00, purchaseDate: "02/02/02", itemCategory: "cat2", notes: "item 2 notes")]), Collection(name: "testColl2", items: [Item(itemName: "testItem2", itemPhotoURL: nil, model: "testModel#", serialNumber: "testSerial#", purchasePrice: 50.00, valuePrice: 50.00, purchaseDate: "02/02/02", itemCategory: "testCategory", notes: "These are more test notes")])]
    
    //    init(collection: [Collection]) {
    //        self.collection = collection
    //    }
    
    func calculateTotalValue() -> Double {
        //extracting the total value of all items by flatMapping the collection, compactMapping the values, and combining the valuePrice elements with .reduce which starts at 0 and +adds them together, returning the resulting Double.
        if let collection = collection { return collection.compactMap({ $0.value }).reduce(0, +) }
        else { return 0.0 }
        //collections.compactMap({ $0.value }).reduce(0, +)
    }
    
    func calculateNumberOfItems() -> Int {
        if let collection = collection { return collection.compactMap { $0.items.count }.reduce(0, +) }
        else { return 0 }
        
    }
    
    func calculateRoomHigh() -> Collection? {
        //calculating which collection has the highest value property by starting with nil and replacing it with the value of the first collection, and only replacing that value if the current collection being looped on is > the current value. After the loop is complete, we are retuning with the value of the highest valued collection.
        if let collection = collection {
            var highestValuedCollection: Collection? = nil
            for collection in collection {
                if highestValuedCollection == nil {
                    highestValuedCollection = collection
                } else {
                    guard let unwrappedCollection = highestValuedCollection else {
                        return nil
                    }
                    if collection.value >= unwrappedCollection.value {
                        highestValuedCollection = collection
                    }
                }
            }
            return highestValuedCollection
        } else { return nil}
    }
    
    func calculateRoomLow() -> Collection? {
        //calc all room values, compare to find lowest and return it
        var lowestValuedCollection: Collection? = nil
        if let collection = collection {
            for collection in collection {
                if lowestValuedCollection == nil {
                    lowestValuedCollection = collection
                } else {
                    guard let unwrappedCollection = lowestValuedCollection else {
                        return nil
                    }
                    if collection.value <= unwrappedCollection.value {
                        lowestValuedCollection = collection
                    }
                }
            }
            return lowestValuedCollection
        } else { return nil }
    }
    
    func calculateItemHigh() -> Item? {
        if let collection = collection {
            var highestValuedItem: Item? = nil
            for collection in collection {
                for item in collection.items {
                    if highestValuedItem == nil {
                        highestValuedItem = item
                    } else {
                        guard let unwrappedItem = highestValuedItem else { return nil }
                        if item.valuePrice >= unwrappedItem.valuePrice {
                            highestValuedItem = item
                        }
                    }
                }
            }
            return highestValuedItem
        } else { return nil }
    }
    
    func calculateItemLow() -> Item? {
        if let collection = collection {
            var lowestValuedItem: Item? = nil
            for collection in collection {
                for item in collection.items {
                    if lowestValuedItem == nil {
                        lowestValuedItem = item
                    } else {
                        guard let unwrappedItem = lowestValuedItem else { return nil }
                        if item.valuePrice <= unwrappedItem.valuePrice {
                            lowestValuedItem = item
                        }
                    }
                }
            }
            return lowestValuedItem
        } else { return nil }
    }
}

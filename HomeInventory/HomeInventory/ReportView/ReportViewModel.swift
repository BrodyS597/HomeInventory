//
//  ReportViewModel.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/14/22.
//

import Foundation

protocol ReportViewModelDelegate: ReportViewController {
    func reportHasData()
}

class ReportViewModel {
    
    // MARK: -Properties
    var collections: [Collection]? {
        didSet {
            delegate?.reportHasData()
        }
    }
    weak var delegate: ReportViewModelDelegate?
    
    init(delegate: ReportViewModelDelegate) {
        self.delegate = delegate
        fetchCollectionData()
    }
    
    func calculateTotalValue() -> Double {
        //extracting the total value of all items by flatMapping the collection, compactMapping the values, and combining the valuePrice elements with .reduce which starts at 0 and +adds them together, returning the resulting Double.
        if let collection = collections { return collection.compactMap({ $0.value }).reduce(0, +) }
        else { return 0.0 }
    }
    
    func calculateNumberOfItems() -> Int {
        if let collection = collections { return collection.compactMap { $0.items.count }.reduce(0, +) }
        else { return 0 }
    }
    
    func calculateRoomHigh() -> Collection? {
        //calculating which collection has the highest value property by starting with nil and replacing it with the value of the first collection, and only replacing that value if the current collection being looped on is > the current value. After the loop is complete, we are retuning with the value of the highest valued collection.
        if let collection = collections {
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
        if let collection = collections {
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
        if let collection = collections {
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
        if let collection = collections {
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
    
    func fetchCollectionData() {
        FirebaseController().getCollections { result in
            switch result {
            case .success(let collections):
                self.fetchItemDataFrom(collections: collections)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchItemDataFrom(collections: [Collection]) {
        let dispatchGroup = DispatchGroup()
        let collectionArray = collections
        for collection in collectionArray {
            dispatchGroup.enter()
            FirebaseController().getItemsFromCollection(collection: collection) { result in
                switch result {
                case .success(let items):
                    collection.items = items
                case .failure(let error):
                    print(error.localizedDescription)
                }
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.collections = collectionArray
            self.delegate?.reportHasData()
        }
    }
}

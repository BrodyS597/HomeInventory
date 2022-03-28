//
//  ItemVCModel.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/14/22.
//

import Foundation

protocol ItemVCDelegate: ItemsViewController {
    func itemsFetchedSuccessfully()
}

class ItemVCModel {
    
    // MARK: -Properties
    var items: [Item]
    var collection: Collection
    private weak var delegate: ItemVCDelegate?
    
    init(collection: Collection, delegate: ItemVCDelegate) {
        self.collection = collection
        self.items = collection.items
        self.delegate = delegate
    }
    
    func fetchItems() {
        FirebaseController().getItemsFromCollection(collection: collection) { result in
            switch result {
            case .success(let items):
                self.items = items
                self.delegate?.itemsFetchedSuccessfully()
            case .failure(let error):
                print(error.errorDescription)
            }
        }
    }
}

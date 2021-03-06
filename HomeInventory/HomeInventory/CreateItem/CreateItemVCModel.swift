//
//  CreateItemVCModel.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/14/22.
//

import Foundation
import UIKit

class CreateItemVCModel {
    
    // MARK: -Properties
    var item: Item?
    var collection: Collection?
    
    init(item: Item?, collection: Collection) {
        self.collection = collection
        self.item = item
    }
    
    func saveItem(toCollection: Collection, itemName: String, itemPhotoURL: UIImage?, model: String, serialNumber: String, purchasePrice: Double, valuePrice: Double, purchaseDate: String, itemCategory: String, notes: String) {
        if let item = item {
            item.itemName = itemName
            item.model = model
            item.serialNumber = serialNumber
            item.purchasePrice = purchasePrice
            item.valuePrice = valuePrice
            item.purchaseDate = purchaseDate
            item.itemCategory = itemCategory
            item.notes = notes
            
            collection?.items.append(item)
            FirebaseController().saveItemToCollection(item: item, collection: collection!)
            if let itemPhotoURL = itemPhotoURL {
                Network.shared.cache.setObject(itemPhotoURL, forKey: item.uuid as NSString)
                FireBaseStorageController().saveImageDataToItem(image: itemPhotoURL, toItem: item)
            }
        } else {
            let item = Item(itemName: itemName, model: model, serialNumber: serialNumber, purchasePrice: purchasePrice, valuePrice: valuePrice, purchaseDate: purchaseDate, itemCategory: itemCategory, notes: notes)
            collection?.items.append(item)
            FirebaseController().saveItemToCollection(item: item, collection: collection!)
            
            if let itemPhotoURL = itemPhotoURL {
                Network.shared.cache.setObject(itemPhotoURL, forKey: item.uuid as NSString)
                FireBaseStorageController().saveImageDataToItem(image: itemPhotoURL, toItem: item)
            }
        }
    }
    
    func deleteItem() {
        guard let item = item,
              let collection = collection else { return }
        FirebaseController().deleteItemFromCollection(item, collection: collection)
    }
    
    func fetchImage(completion: @escaping (UIImage?) -> Void) {
        guard let item = item else { return }
        FireBaseStorageController().loadImageFromItem(fromItem: item) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print(error.description)
                completion(nil)
            }
        }
    }
}

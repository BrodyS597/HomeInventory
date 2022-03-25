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
    private let viewModel: ItemVCModel
    //private let collectionViewModel: HomeVCModel
    //private weak var delegate: ItemVCDelegate?
    
    init(viewModel: ItemVCModel) {
        self.viewModel = viewModel
        self.collection = viewModel.collection
        //self.collectionViewModel = collectionViewModel
   }
    
    func saveItem(toCollection: Collection, itemName: String, itemPhotoURL: UIImage?, model: String, serialNumber: String, purchasePrice: Double, valuePrice: Double, purchaseDate: String, itemCategory: String, notes: String) {
        if let item = item {
            item.itemName = itemName
            //item.itemPhotoURL = itemPhotoURL
            item.model = model
            item.serialNumber = serialNumber
            item.purchasePrice = purchasePrice
            item.valuePrice = valuePrice
            item.purchaseDate = purchaseDate
            item.itemCategory = itemCategory
            item.notes = notes
        } else {
            let item = Item(itemName: itemName, model: model, serialNumber: serialNumber, purchasePrice: purchasePrice, valuePrice: valuePrice, purchaseDate: purchaseDate, itemCategory: itemCategory, notes: notes)
            collection?.items.append(item)
           //viewModel.items.append(self.item!)
         //   collectionViewModel.collection.append(self.item!)

            FirebaseController().saveItemToCollection(item: item, collection: collection!)
        }
        //firebaseController().saveItem(self.item!) //SAVES ITEM OUT OF COLLECTION BODY IN FSDB
        
//        guard let imagedata = image?.pngData() else { return }
//        FirebaseStorageController().save(imagedata, toItem: item!)
    }
    
    func deleteItem() {
//        guard let item = item else { return }
//        firebaseController().deleteItem(item, collection: collection!)
    }
    
    func saveImage() {
        //save image when first set
    }
    
    func fetchImage() {
        //from firebase when item is loaded
    }
}

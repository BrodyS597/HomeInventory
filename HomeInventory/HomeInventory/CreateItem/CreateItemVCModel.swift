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
    private let viewModel: ItemVCModel
    //private weak var delegate: ItemVCDelegate?
    
    init(item: Item? = nil, viewModel: ItemVCModel) {
        self.item = item
        self.viewModel = viewModel
   }
    
    func saveItem(itemName: String, itemPhotoURL: UIImage?, model: String, serialNumber: String, purchasePrice: Double, valuePrice: Double, purchaseDate: String, itemCategory: String, notes: String) {
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
            item = Item(itemName: itemName, model: model, serialNumber: serialNumber, purchasePrice: purchasePrice, valuePrice: valuePrice, purchaseDate: purchaseDate, itemCategory: itemCategory, notes: notes)
            viewModel.items.append(self.item!)
        }
        firebaseController().saveItem(self.item!)
//        guard let imagedata = image?.pngData() else { return }
//        FirebaseStorageController().save(imagedata, toItem: item!)
    }
    
    func saveImage() {
        //save image when first set
    }
    
    func fetchImage() {
        //from firebase when item is loaded
    }
}

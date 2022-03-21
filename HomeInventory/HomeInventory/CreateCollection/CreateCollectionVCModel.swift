//
//  CreateCollectionVCModel.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/21/22.
//

import Foundation

class CreateCollectionVCModel {
    
    // MARK: -Properties
    var collection: Collection?
    
    init(collection: Collection) {
        self.collection = collection
   }
    
    func saveCollection(name: String) {
        if let collection = collection {
            collection.name = name
        } else {
            collection = Collection(name: name, items: [])
        }
        //save to firebase using save func in FBC file ie. FirebaseController().saveCollection etc
    }
    
    func saveImage() {
        //save image when first set
    }
    
    func fetchImage() {
        //from firebase when item is loaded
    }
}

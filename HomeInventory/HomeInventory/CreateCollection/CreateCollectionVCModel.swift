//
//  CreateCollectionVCModel.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/21/22.
//

import Foundation
import UIKit

class CreateCollectionVCModel {
    
    // MARK: -Properties
    var collection: Collection?
    private let viewModel: HomeVCModel
    
    init(collection: Collection? = nil, viewModel: HomeVCModel) {
        self.collection = collection
        self.viewModel = viewModel
   }
    
    func saveCollection(name: String) {
        if let collection = collection {
            collection.name = name
        } else {
            collection = Collection(name: name, items: [])
            viewModel.collection.append(self.collection!)
        }
        firebaseController().saveCollection(self.collection!)
        
//        guard let imagedata = image?.pngData() else { return }
//        FirebaseStorageController().save(imagedata, toCollection: collection!)
        //save to firebase using save func in FBC file ie. FirebaseController().saveCollection etc
    }
    
    func saveImage() {
        //save image when first set
    }
    
    func fetchImage(completion: @escaping (UIImage?) -> Void) {
        guard let collection = collection else { return }
        FireBaseStorageController().loadImage(fromCollection: collection) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print(error.description)
                completion(nil)
            }
        }
        //from firebase when item is loaded
    }
}

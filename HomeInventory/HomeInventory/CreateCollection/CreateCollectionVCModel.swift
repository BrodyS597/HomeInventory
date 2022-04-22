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
    
    func saveCollection(image: UIImage?) {
        guard let collection = collection else { return }
        viewModel.collections.append(collection)
        FirebaseController().saveCollection(collection)
        
        guard let imageData = image?.pngData() else { return }
        FireBaseStorageController().saveImageDataToCollection(imageData, toCollection: collection)
    }
    
    func fetchImage(completion: @escaping (UIImage?) -> Void) {
        guard let collection = collection else { return }
        FireBaseStorageController().loadImageFromCollection(fromCollection: collection) { result in
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

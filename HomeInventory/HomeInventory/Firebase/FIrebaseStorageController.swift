//
//  FIrebaseStorageController.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/14/22.
//

import Foundation
import FirebaseStorage
import UIKit.UIImage

struct FireBaseStorageController {
    let storage = Storage.storage().reference()
    
    func saveImageDataToCollection(_ imageData: Data, toCollection collection: Collection) {
        storage.child(collection.imagePath).putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print(error)
                return
            }
            self.storage.child(collection.imagePath).downloadURL { url, error in
                if let error = error {
                    print(error)
                    return
                }
                collection.imageURL = url
            }
        }
    }
    
    func loadImageFromCollection(fromCollection collection: Collection, completion: @escaping (Result<UIImage, FirebaseError>) -> Void) {
        storage.child(collection.imagePath).getData(maxSize: 4000 * 4000) { data, error in
            if let error = error {
                completion(.failure(.failure(error)))
                return
            }
            guard let data = data,
                  let image = UIImage(data: data)
            else { completion(.failure(.noData)); return }
            completion(.success(image))
        }
    }
    
    func deleteImageFromCollection(fromCollection collection: Collection) {
        storage.child(collection.imagePath).delete(completion: nil)

    }
    
    func loadImageFromItem(fromItem item: Item, completion: @escaping (Result<UIImage, FirebaseError>) -> Void) {
        storage.child(item.imagePath).getData(maxSize: 4000 * 4000) { data, error in
            if let error = error {
                completion(.failure(.failure(error)))
                return
            }
            guard let data = data,
                  let image = UIImage(data: data)
            else { completion(.failure(.noData)); return }
            completion(.success(image))
        }
    }
    
    func deleteImageFromItem(fromItem item: Item) {
        storage.child(item.imagePath).delete(completion: nil)
    }
}

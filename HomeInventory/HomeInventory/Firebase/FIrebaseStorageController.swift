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
        guard let uid = UserDefaults.standard.string(forKey: "uid") else { return }
        storage.child("users")
            .child(uid)
            .child(collection.imagePath)
            .putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print(error)
                return
            }
                guard let uid = UserDefaults.standard.string(forKey: "uid") else { return }
                storage.child("users")
                    .child(uid)
                    .child(collection.imagePath)
                    .downloadURL { url, error in
                if let error = error {
                    print(error)
                    return
                }
                collection.imageURL = url
            }
        }
    }
    
    func loadImageFromCollection(fromCollection collection: Collection, completion: @escaping (Result<UIImage, FirebaseError>) -> Void) {
        guard let uid = UserDefaults.standard.string(forKey: "uid") else { return }
        storage.child("users")
            .child(uid)
            .child(collection.imagePath)
            .getData(maxSize: 4000 * 4000) { data, error in
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
        guard let uid = UserDefaults.standard.string(forKey: "uid") else { return }
        storage.child("users")
            .child(uid)
            .child(collection.imagePath)
            .delete(completion: nil)
    }
    
    func saveImageDataToItem(_ imageData: Data, toItem item: Item) {
        guard let uid = UserDefaults.standard.string(forKey: "uid") else { return }
        storage.child("users")
            .child(uid)
            .child(item.imagePath)
            .putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print(error)
                return
            }
            self.storage.child(item.imagePath).downloadURL { url, error in
                if let error = error {
                    print(error)
                    return
                }
                item.itemPhotoURL = url
            }
        }
    }
    
    func loadImageFromItem(fromItem item: Item, completion: @escaping (Result<UIImage, FirebaseError>) -> Void) {
        guard let uid = UserDefaults.standard.string(forKey: "uid") else { return }
        storage.child("users")
            .child(uid)
            .child(item.imagePath)
            .getData(maxSize: 4000 * 4000) { data, error in
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
        guard let uid = UserDefaults.standard.string(forKey: "uid") else { return }
        storage.child("users")
            .child(uid)
            .child(item.imagePath)
            .delete(completion: nil)
    }
}

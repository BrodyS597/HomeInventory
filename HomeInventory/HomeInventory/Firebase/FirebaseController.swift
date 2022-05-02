//
//  FirebaseController.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/14/22.
//

import Foundation
import FirebaseFirestore

enum FirebaseError: LocalizedError {
    case failure(Error)
    case noData
    case failedToDecode
    
    var description: String {
        switch self {
        case .failure(let error):
            return "\(error.localizedDescription) -> \(error)"
        case .noData:
            return "No data found!"
        case .failedToDecode:
            return "Unable to decode data"
        }
    }
}

struct FirebaseController {
    let database = Firestore.firestore()
    
    func saveCollection(_ collection: Collection) {
        
        guard let uid = UserDefaults.standard.string(forKey: "uid") else { return }
        database.collection("users")
                .document(uid)
                .collection(Collection.Key.collectionType)
                .document(collection.uuid)
                .setData(collection.CollectionData)
    }
    
    func saveItemToCollection(item: Item, collection: Collection) {
        guard let uid = UserDefaults.standard.string(forKey: "uid") else { return }
        database.collection("users")
                .document(uid)
                .collection(Collection.Key.collectionType)
                .document(collection.uuid)
                .collection(Collection.Key.items).document(item.uuid).setData(item.itemData)
    }
    
    func deleteCollection(_ collection: Collection, completion: ((Result<Bool, FirebaseError>) -> Void)?) {
        guard let uid = UserDefaults.standard.string(forKey: "uid") else { return }
        database.collection("users")
            .document(uid)
            .collection(Collection.Key.collectionType)
            .document(collection.uuid).delete { error in
                if let error = error {
                    print(error.localizedDescription)
                    completion?(.failure(.failure(error)))
                } else {
                    FireBaseStorageController().deleteImageFromCollection(fromCollection: collection, completion: completion)
                    // For loop to delete each item 
                }
            }
    }
    
    func deleteItemFromCollection(_ item: Item, collection: Collection) {
        guard let uid = UserDefaults.standard.string(forKey: "uid") else { return }
        database.collection("users")
            .document(uid)
            .collection(Collection.Key.collectionType)
            .document(collection.uuid)
            .collection(Collection.Key.items)
            .document(item.uuid).delete()
        FireBaseStorageController().deleteImageFromItem(fromItem: item)
    }
    
    func getCollections(completion: @escaping (Result<[Collection], FirebaseError>) -> Void) {
        guard let uid = UserDefaults.standard.string(forKey: "uid") else { return }
        database.collection("users")
            .document(uid)
            .collection(Collection.Key.collectionType)
            .getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(.failure(error)))
                return
            }
            guard let data = snapshot?.documents else { completion(.failure(.noData)); return }
            let dataArray = data.compactMap({ $0.data() })
            let collectionArray = dataArray.compactMap({ Collection(fromDictionary: $0) })
            completion(.success(collectionArray))
        }
    }
    
    func getItemsFromCollection(collection: Collection, completion: @escaping (Result<[Item], FirebaseError>) -> Void) {
        guard let uid = UserDefaults.standard.string(forKey: "uid") else { return }
        database.collection("users")
            .document(uid)
            .collection(Collection.Key.collectionType)
            .document(collection.uuid)
            .collection(Collection.Key.items)
            .getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(.failure(error)))
                return
            }
            guard let data = snapshot?.documents else { completion(.failure(.noData)); return }
            let dataArray = data.compactMap({ $0.data() })
            let itemsArray = dataArray.compactMap({ Item(fromDictionary: $0) })
            completion(.success(itemsArray))
        }
    }
}

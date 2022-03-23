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


struct firebaseController {
    let database = Firestore.firestore()
    
    func saveCollection(_ collection: Collection) {
        database.collection(Collection.Key.collectionType).document(collection.uuid).setData(collection.CollectionData)

    }
    
    func saveItem(_ item: Item) {
        database.collection(Item.Key.collectionType).document(item.uuid).setData(item.itemData)
    }
    
    func deleteCollection(_ collection: Collection) {
        database.collection(Collection.Key.collectionType).document(collection.uuid).delete()
        FireBaseStorageController().deleteImage(fromCollection: collection)
    }
    
    func deleteItem(_ item: Item) {
        database.collection(Item.Key.collectionType).document(item.uuid).delete()
        FireBaseStorageController().deleteImage(fromItem: item)
    }
    
    func getCollections(completion: @escaping (Result<[Collection], FirebaseError>) -> Void) {
        database.collection(Collection.Key.collectionType).getDocuments { snapshot, error in
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
    
//    func getItems() {
//
//    }
    
}

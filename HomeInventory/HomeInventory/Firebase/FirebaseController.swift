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
        database.collection(Collection.Key.collectionType).document(collection.uuid).setData(collection.CollectionData)
        
    }
    
    func saveItemToCollection(item: Item, collection: Collection) {
        //may need to change including array union so this stuff saves nested under collecitonData, specifically under "items" array
        database.collection(Collection.Key.collectionType).document(collection.uuid).collection(Collection.Key.items).document(item.uuid).setData(item.itemData)
    }
    
    func deleteCollection(_ collection: Collection) {
        
    }
    
    func deleteItemFromCollection(_ item: Item, collection: Collection) {
        //database.collection(Collection.Key.collectionType).document(collection.uuid).collection("items").document(item.uuid).delete()
        //database.collection(Item.Key.collectionType).document(item.uuid).delete()
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
    
    func getItemsFromCollection(collection: Collection, completion: @escaping (Result<[Item], FirebaseError>) -> Void) {
        database.collection(Collection.Key.collectionType).document(collection.uuid).collection(Collection.Key.items).getDocuments { snapshot, error in
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

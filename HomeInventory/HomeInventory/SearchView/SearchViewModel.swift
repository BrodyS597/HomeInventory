//
//  SearchViewModel.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/14/22.
//

import Foundation

protocol SearchViewModelDelegate: SearchViewController {
    func searchHasData()
}

class SearchViewModel {
    
    // MARK: - Properties
    var collections = [Collection]()
    var collectionsArray: [Collection] = []
    var collection: Collection?
    var item: Item?
    var items = [Item]()
    var tempItemArray: [Item] = []
    weak var delegate: SearchViewModelDelegate?
    
    init(delegate: SearchViewModelDelegate) {
        self.delegate = delegate
        fetchCollections()
        fetchItemDataFrom(collections: collections)
    }
    
    func fetchCollections() {
        FirebaseController().getCollections { result in
            switch result {
            case .success(let collections):
                self.collections = collections
                self.collectionsArray = collections
                self.fetchItemDataFrom(collections: collections)
            case .failure(let error):
                print(error.description)
            }
        }
    }
    
    func fetchItemDataFrom(collections: [Collection]) {
        let dispatchGroup = DispatchGroup()
        let collectionArray = collectionsArray
        var tempItemArray = tempItemArray
        for collection in collectionArray {
            dispatchGroup.enter()
            FirebaseController().getItemsFromCollection(collection: collection) { result in
                switch result {
                case .success(let items):
                    tempItemArray += items
                    self.items += items
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.collections = collectionArray
            self.tempItemArray = tempItemArray
            self.delegate?.searchHasData()
        }
    }
}

//
//  HomeVCModel.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/14/22.
//

import Foundation

protocol HomeVCModelDelegate: HomeViewController {
    func updateViews()
}

class HomeVCModel {
    
    // MARK: -Properties
    var collections = [Collection]()
    var collection: Collection?
    var userID: String?
    private weak var delegate: HomeVCModelDelegate?
    
    init(delegate: HomeVCModelDelegate) {
        self.delegate = delegate
        self.fetchCollections()
    }
    
    private func fetchCollections() {
        FirebaseController().getCollections { result in
            switch result {
            case .success(let collections):
                self.collections = collections
                self.delegate?.updateViews()
            case .failure(let error):
                print(error.description)
            }
        }
    }
}

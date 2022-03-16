//
//  HomeVCModel.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/14/22.
//

import Foundation

protocol HomeVCDelegate: HomeViewController {
    
}

class HomeVCModel {
    
    // MARK: -Properties
    var collection = [Collection]()
    private weak var delegate: HomeVCDelegate?
    
    init(delegate: HomeVCDelegate) {
        self.delegate = delegate
    }
    
    private func fetchGroups(){
        //from firebase
    }
}

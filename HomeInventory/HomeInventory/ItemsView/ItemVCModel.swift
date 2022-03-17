//
//  ItemVCModel.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/14/22.
//

import Foundation

protocol ItemVCDelegate: ItemsViewController {
    
}

class ItemVCModel {
    
    // MARK: -Properties
    var items: [Item]
    //private weak var delegate: ItemVCDelegate?
    
    init(items: [Item]) {
        self.items = items
    }
    
//    init(delegate: ItemVCDelegate) {
//        self.delegate = delegate
//    }
    
    private func fetchItems(){
        //from firebase
    }
    
    func search() {
        
    }
    
    func deleteItem() {
        
    }
}

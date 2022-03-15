//
//  HomeViewController.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/10/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: -IBOutlets
    @IBOutlet weak var groupCollectionView: UICollectionView!
    
    // MARK: -Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    override func viewWillAppear() {
//
//    }
    
    
      // MARK: -Navigation
     
    func groupCollectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0 //group.count
    }
    
//    func groupCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//
//        return cell
//    }
    
}

//
//  HomeViewController.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/10/22.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: -IBOutlets
    @IBOutlet weak var groupCollectionView: UICollectionView!
    
    // MARK: -Properties
    var viewModel: HomeVCModel!
    let dataSource: [String] = ["test garage", "test livingroom", "test bathroom", "test bedroom"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeVCModel(delegate: self)
        groupCollectionView.dataSource = self
        groupCollectionView.delegate = self
    
        //Registering the custom cell
        self.groupCollectionView.register(UINib(nibName: "HomeViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeViewCell")
        
        groupCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(dataSource.count)
        return self.dataSource.count
        //viewModel.collection.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeViewCell", for: indexPath) as? HomeCollectionViewCell {
            customCell.configure(with: dataSource[indexPath.row])
            return customCell
            
        }
        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
//    override func viewWillAppear() {
//
//    }

}

extension HomeViewController: HomeVCDelegate {
    
}

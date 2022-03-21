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
    let dataSource: [Collection] = [ Collection(name: "testCollection1", items: [Item(itemName: "testTV", itemPhotoURL: nil, model: "testmodel#", serialNumber: "testSerial#", purchasePrice: 23.00, valuePrice: 23.00, purchaseDate: "01/01/01", itemCategory: "testCategory", notes: "These are test notes"), Item(itemName: "testItem2", itemPhotoURL: nil, model: "123M", serialNumber: "456789", purchasePrice: 90.00, valuePrice: 90.00, purchaseDate: "02/02/02", itemCategory: "cat2", notes: "item 2 notes")]), Collection(name: "testCollection2", items: [Item(itemName: "testItem2", itemPhotoURL: nil, model: "testModel#", serialNumber: "testSerial#", purchasePrice: 50.00, valuePrice: 50.00, purchaseDate: "02/02/02", itemCategory: "testCategory", notes: "These are more test notes")])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeVCModel()
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
            customCell.configure(with: dataSource[indexPath.row].name)
            //customCell.groupImageView.image = UIImage
            customCell.layer.cornerRadius = customCell.frame.height / 10
            return customCell
            
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(dataSource[indexPath.row])
        
        let storyboard = UIStoryboard(name: "ItemsView", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "ItemsViewController") as? ItemsViewController else { return }
        let collection = dataSource[indexPath.row].items
        viewController.viewModel = ItemVCModel(items: collection)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
//    override func viewWillAppear() {
//
//    }

}

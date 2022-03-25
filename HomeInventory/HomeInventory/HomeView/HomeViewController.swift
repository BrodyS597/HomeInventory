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
//    let dataSource: [Collection] = [ Collection(name: "testColl1", items: [Item(itemName: "testTV", itemPhotoURL: nil, model: "testmodel#", serialNumber: "testSerial#", purchasePrice: 23.00, valuePrice: 23.00, purchaseDate: "01/01/01", itemCategory: "testCategory", notes: "These are test notes"), Item(itemName: "testItem2", itemPhotoURL: nil, model: "123M", serialNumber: "456789", purchasePrice: 90.00, valuePrice: 90.00, purchaseDate: "02/02/02", itemCategory: "cat2", notes: "item 2 notes")]), Collection(name: "testColl2", items: [Item(itemName: "testItem2", itemPhotoURL: nil, model: "testModel#", serialNumber: "testSerial#", purchasePrice: 50.00, valuePrice: 50.00, purchaseDate: "02/02/02", itemCategory: "testCategory", notes: "These are more test notes")])]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeVCModel(delegate: self)
        groupCollectionView.dataSource = self
        groupCollectionView.delegate = self
        
        //Registering the custom collection view with the custom item cell and custom add cell
        self.groupCollectionView.register(UINib(nibName: "HomeViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeViewCell")
        self.groupCollectionView.register(HomeAddCellViewController.nib(), forCellWithReuseIdentifier: "HomeAddCell")
        groupCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.collection.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            if let customAddCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeAddCell", for: indexPath) as? HomeAddCellViewController {
                //customCell.groupImageView.image = UIImage
                customAddCell.layer.cornerRadius = customAddCell.frame.height / 10
                return customAddCell
            }
        } else {
                 if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeViewCell", for: indexPath) as? HomeCollectionViewCell {
                     customCell.configure(with: viewModel.collection[indexPath.row - 1 ].name)
                    //customCell.groupImageView.image = UIImage
                    customCell.layer.cornerRadius = customCell.frame.height / 10
                    return customCell
                }
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: "HomeViewCell", for: indexPath)
    }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if indexPath.row == 0 {
                let storyboard = UIStoryboard(name: "CreateCollectionView", bundle: nil)
                guard let viewController = storyboard.instantiateViewController(withIdentifier: "CreateCollectionView") as? CreateCollectionViewController else { return }
                viewController.viewModel = CreateCollectionVCModel(viewModel: viewModel)
                self.navigationController?.pushViewController(viewController, animated: true)
            } else {
                let storyboard = UIStoryboard(name: "ItemsView", bundle: nil)
                guard let viewController = storyboard.instantiateViewController(withIdentifier: "ItemsViewController") as? ItemsViewController else { return }
                //let collection = viewModel.collection[indexPath.row - 1 ].items
                viewController.viewModel = ItemVCModel(collection: viewModel.collection[indexPath.row - 1], delegate: viewController)
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
    }

extension HomeViewController: HomeVCModelDelegate {
    func updateViews() {
        DispatchQueue.main.async {
            self.groupCollectionView.reloadData()
        }
    }
}

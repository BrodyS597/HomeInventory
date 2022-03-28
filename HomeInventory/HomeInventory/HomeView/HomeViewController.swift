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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeVCModel(delegate: self)
        groupCollectionView.dataSource = self
        groupCollectionView.delegate = self
        
        //Registering the custom collection view with the custom item cell and custom add cell
        self.groupCollectionView.register(UINib(nibName: "HomeViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeViewCell")
        self.groupCollectionView.register(HomeAddCellViewController.nib(), forCellWithReuseIdentifier: "HomeAddCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.collections.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            if let customAddCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeAddCell", for: indexPath) as? HomeAddCellViewController {
                customAddCell.layer.cornerRadius = customAddCell.frame.height / 10
                return customAddCell
            }
        } else {
            if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeViewCell", for: indexPath) as? HomeCollectionViewCell {
                FireBaseStorageController().loadImageFromCollection(fromCollection: viewModel.collections[indexPath.row - 1]) { result in
                    switch result {
                    case .success(let image):
                        customCell.configure(with: self.viewModel.collections[indexPath.row - 1 ].name, image: image)
                        
                    case.failure(let error):
                        print(error)
                        customCell.configure(with: self.viewModel.collections[indexPath.row - 1].name, image: nil)
                    }
                }
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
            viewController.viewModel = ItemVCModel(collection: viewModel.collections[indexPath.row - 1], delegate: viewController)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension HomeViewController: HomeVCModelDelegate {
    func updateViews() {
        DispatchQueue.main.async {
            self.groupCollectionView.reloadData()
        }
    }
}

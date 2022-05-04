//
//  ItemsViewController.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/10/22.
//

import UIKit

class ItemsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: -IBOutlets
    @IBOutlet weak var itemCollectionView: UICollectionView!
    @IBOutlet weak var groupNameLabel: UILabel!
    
    // MARK: -Properties
    var viewModel: ItemVCModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemCollectionView.dataSource = self
        itemCollectionView.delegate = self
        
        //registering the custom cell
        self.itemCollectionView.register(UINib(nibName: "ItemsViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemsViewCell")
        self.itemCollectionView.register(UINib(nibName: "ItemsViewAddCell", bundle: nil), forCellWithReuseIdentifier: "ItemsViewAddCell")
        updateViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchItems()
        navigationController?.navigationBar.tintColor = .lightTeal
    }
    
    func updateViews() {
        //groupNameLabel.text = viewModel.collection.name
        self.title = viewModel.collection.name
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel.items.count)
        return viewModel.items.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            if let customAddCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemsViewAddCell", for: indexPath) as? ItemsViewAddCellView {
                customAddCell.layer.cornerRadius = customAddCell.frame.height / 10
                return customAddCell
            }
        } else {
            if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemsViewCell", for: indexPath) as? ItemsViewCellCollectionViewCell {
                FireBaseStorageController().loadImageFromItem(fromItem: viewModel.items[indexPath.row - 1]) { result in
                    switch result {
                    case .success(let image):
                        customCell.configure(with: self.viewModel.items[indexPath.row - 1].itemName, image: image)
                        
                    case .failure(let error):
                        print(error)
                        customCell.configure(with: self.viewModel.items[indexPath.row - 1].itemName, image: nil)
                    }
                }
                customCell.layer.cornerRadius = customCell.frame.height / 10
                return customCell
            }
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: "ItemsViewCell", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let storyboard = UIStoryboard(name: "CreateItemView", bundle: nil)
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "CreateItemView") as? CreateItemViewController else { return }
            viewController.viewModel = CreateItemVCModel(item: nil, collection: viewModel.collection)
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            let storyboard = UIStoryboard(name: "CreateItemView", bundle: nil)
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "CreateItemView") as? CreateItemViewController else { return }
            viewController.viewModel = CreateItemVCModel(item: viewModel.items[indexPath.row - 1], collection: viewModel.collection)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension ItemsViewController: ItemVCDelegate {
    func itemsFetchedSuccessfully() {
        itemCollectionView.reloadData()
    }
}

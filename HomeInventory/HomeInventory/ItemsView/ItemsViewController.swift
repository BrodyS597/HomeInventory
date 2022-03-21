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
        
        itemCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel.items.count)
        return viewModel.items.count
        //viewModel.item.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemsViewCell", for: indexPath) as? ItemsViewCellCollectionViewCell {
            customCell.configure(with: viewModel.items[indexPath.row].itemName)
            print(viewModel.items)
            //customCell.groupImageView.image = UIImage
            customCell.layer.cornerRadius = customCell.frame.height / 10
            return customCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(viewModel.items[indexPath.row])
        
        let storyboard = UIStoryboard(name: "CreateItemView", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "CreateItemViewController") as? CreateItemViewController else { return }
        let item = self.viewModel.items[indexPath.row]
        viewController.viewModel = CreateItemVCModel(item: item)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // MARK: -Configure Cell
    //self.firstText = groupname etc
    //sizing
}

extension ItemsViewController: ItemVCDelegate {
    
}

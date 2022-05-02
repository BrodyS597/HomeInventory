//
//  HomeViewController.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/10/22.
//

import UIKit

protocol HomeViewControllerDelegate {
    
}

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate {
    
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
        //  setupLongGestureRecognizerOnCollection()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupCollectionView.reloadData()
        self.navigationController?.navigationBar.isHidden = true
        //  setupLongGestureRecognizerOnCollection()
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
                customCell.delegate = self
                customCell.configure(with: viewModel.collections[indexPath.row - 1])
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
            self.navigationController?.navigationBar.isHidden = false
        } else {
            let storyboard = UIStoryboard(name: "ItemsView", bundle: nil)
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "ItemsViewController") as? ItemsViewController else { return }
            viewController.viewModel = ItemVCModel(collection: viewModel.collections[indexPath.row - 1], delegate: viewController)
            self.navigationController?.pushViewController(viewController, animated: true)
            self.navigationController?.navigationBar.isHidden = false
        }
    }
    
    // MARK: - 2
    //    private func setupLongGestureRecognizerOnCollection() {
    //        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
    //        longPressedGesture.minimumPressDuration = 0.5
    //        longPressedGesture.delegate = self
    //        longPressedGesture.delaysTouchesBegan = true
    //        groupCollectionView.addGestureRecognizer(longPressedGesture)
    //    }
    
    func deleteAlertController(collectionToDelete: Collection) {
        let alertActionCell = UIAlertController(title: "Would you like to delete this Collection?", message: "This will also delete all the items contained within, and CANNOT be undone.", preferredStyle: .actionSheet)
        
        // Configure Remove Item Action
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            guard let index = self.viewModel.collections.firstIndex(of: collectionToDelete) else { return }
            FirebaseController().deleteCollection(collectionToDelete) { result in
                switch result {
                case .success:
                    print("Cell Removed")
                    self.viewModel.collections.remove(at: index)
                    self.groupCollectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        })
        
        // Configure Cancel Action Sheet
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            print("Cancel actionsheet")
        })
        
        alertActionCell.addAction(deleteAction)
        alertActionCell.addAction(cancelAction)
        self.present(alertActionCell, animated: true, completion: nil)
    }
}

extension HomeViewController: HomeCollectionViewCellDelegate {
    func presentAlertToDelete(collection: Collection) {
        deleteAlertController(collectionToDelete: collection)
      //  self.groupCollectionView.reloadData()
    }
}

extension HomeViewController: HomeVCModelDelegate {
    func updateViews() {
        DispatchQueue.main.async {
            self.groupCollectionView.reloadData()
        }
    }
}

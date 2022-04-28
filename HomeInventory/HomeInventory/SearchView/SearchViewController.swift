//
//  SearchViewController.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/11/22.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemsViewCell", for: indexPath) as? ItemsViewCellCollectionViewCell {
            FireBaseStorageController().loadImageFromItem(fromItem: viewModel.items[indexPath.row]) { result in
                switch result {
                case .success(let image):
                    customCell.configure(with: self.viewModel.items[indexPath.row].itemName, image: image)
                case .failure(let error):
                    print(error)
                    customCell.configure(with: self.viewModel.items[indexPath.row].itemName, image: nil)
                }
            }
            customCell.layer.cornerRadius = customCell.frame.height / 10
            return customCell
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: "ItemsViewCell", for: indexPath)
    }
    
    
    // MARK: -IBOutlets
    @IBOutlet weak var searchCollectionView: UICollectionView!
    @IBOutlet weak var itemSearchBar: UISearchBar!
    
    // MARK: -Properties
    var viewModel: SearchViewModel!
    var itemViewModel: ItemVCModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemSearchBar.delegate = self
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        viewModel = SearchViewModel(delegate: self)
        //registering the custom cell
        self.searchCollectionView.register(UINib(nibName: "ItemsViewCell", bundle: nil), forCellWithReuseIdentifier: "ItemsViewCell")
    }
    
    // MARK: -IBActions
    @IBOutlet weak var searchButtonTapped: UISearchBar!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.items = viewModel.tempItemArray
        itemSearchBar.resignFirstResponder()
        performSearch()
        searchCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        itemSearchBar.resignFirstResponder()
        itemSearchBar.text = nil
        viewModel.items.removeAll()
        viewModel.items = viewModel.tempItemArray
        searchCollectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.items.removeAll()
            viewModel.items = viewModel.tempItemArray
            searchCollectionView.reloadData()
        }
    }
    
    func performSearch() {
        let data = viewModel.items
        var filteredData = viewModel.items
        guard let searchText = itemSearchBar.text else { return }
        if !searchText.isEmpty == true {
            filteredData = data.filter({ $0.itemName.lowercased().contains(searchText.lowercased()) ||
                $0.model.lowercased().contains(searchText.lowercased()) ||
                $0.serialNumber.lowercased().contains(searchText.lowercased()) ||
                $0.purchaseDate.lowercased().contains(searchText.lowercased()) ||
                $0.itemCategory.lowercased().contains(searchText.lowercased()) ||
                $0.notes.lowercased().contains(searchText.lowercased())
            })
        }
        viewModel.items = filteredData
        searchCollectionView.reloadData()
    }
    
    func collectionView(_ searchCollectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "CreateItemView", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "CreateItemView") as? CreateItemViewController else { return }
        viewController.viewModel = CreateItemVCModel(item: viewModel.items[indexPath.row], viewModel: self.itemViewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func searchHasData() {
        DispatchQueue.main.async {
            self.searchCollectionView.reloadData()
        }
    }
}
    

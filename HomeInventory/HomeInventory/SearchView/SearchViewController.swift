//
//  SearchViewController.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/11/22.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.tupleArrayFilterable.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemsViewCell", for: indexPath) as? ItemsViewCellCollectionViewCell {
            FireBaseStorageController().loadImageFromItem(fromItem: viewModel.tupleArrayFilterable[indexPath.row].0) { result in
                switch result {
                case .success(let image):
                    customCell.configure(with: self.viewModel.tupleArrayFilterable[indexPath.row].0.itemName, image: image)
                case .failure(let error):
                    print(error)
                    customCell.configure(with: self.viewModel.tupleArrayFilterable[indexPath.row].0.itemName, image: nil)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchCollectionView.reloadData()
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: -IBActions
    @IBOutlet weak var searchButtonTapped: UISearchBar!
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.tupleArrayFilterable = viewModel.tupleArrayFull // causes the filtered count to be the master count when full = filterable
        itemSearchBar.resignFirstResponder()
        performSearch()
        searchCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        itemSearchBar.resignFirstResponder()
        itemSearchBar.text = nil
        viewModel.tupleArrayFilterable.removeAll()
        viewModel.tupleArrayFilterable = viewModel.tupleArrayFull
        searchCollectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.tupleArrayFilterable.removeAll()
            viewModel.tupleArrayFilterable = viewModel.tupleArrayFull
            searchCollectionView.reloadData()
        }
    }
    
    func performSearch() {
        viewModel.tupleArrayFilterable = viewModel.tupleArrayFull
        let data = viewModel.tupleArrayFilterable
        var filteredData = viewModel.tupleArrayFilterable
        guard let searchText = itemSearchBar.text else { return }
        if !searchText.isEmpty == true {
            filteredData = data.filter({ $0.0.itemName.lowercased().contains(searchText.lowercased()) ||
                $0.0.model.lowercased().contains(searchText.lowercased()) ||
                $0.0.serialNumber.lowercased().contains(searchText.lowercased()) ||
                $0.0.purchaseDate.lowercased().contains(searchText.lowercased()) ||
                $0.0.itemCategory.lowercased().contains(searchText.lowercased()) ||
                $0.0.notes.lowercased().contains(searchText.lowercased())
            })
        }
        if filteredData.isEmpty {
            let emptyResultsAlert = UIAlertController(title: "No items match the keyword you're searching for.", message: "Edit your keyword or cancel the search", preferredStyle: UIAlertController.Style.alert)
            emptyResultsAlert.addAction(UIAlertAction(title: "Okay", style: .default , handler: { (action: UIAlertAction!) in
                //self.itemSearchBar.text = nil
                filteredData.removeAll()
                filteredData = self.viewModel.tupleArrayFull
                self.searchCollectionView.reloadData()
            }))
            present(emptyResultsAlert, animated: true, completion: nil)
            return
        }
        viewModel.tupleArrayFilterable = filteredData
        searchCollectionView.reloadData()
    }
    
    func collectionView(_ searchCollectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "CreateItemView", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "CreateItemView") as? CreateItemViewController else { return }
        viewController.viewModel = CreateItemVCModel(item: viewModel.tupleArrayFilterable[indexPath.row].0, collection: viewModel.tupleArrayFilterable[indexPath.row].1)
        self.navigationController?.pushViewController(viewController, animated: true)
        self.navigationController?.navigationBar.isHidden = false
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func searchHasData() {
        DispatchQueue.main.async {
            self.searchCollectionView.reloadData()
        }
    }
}

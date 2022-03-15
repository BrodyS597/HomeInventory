//
//  SearchViewController.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/11/22.
//

import UIKit

class SearchViewController: UIViewController {

    //needs item view model
    
    // MARK: -IBOutlets
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: -IBActions
    @IBOutlet weak var searchButtonTapped: UISearchBar!
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked() {
        
    }
    
}
    

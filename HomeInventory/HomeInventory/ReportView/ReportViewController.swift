//
//  ReportViewController.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/11/22.
//

import UIKit

class ReportViewController: UIViewController {

// MARK: -IBOutlets
    @IBOutlet weak var totalValueLabel: UILabel!
    @IBOutlet weak var roomHighLabel: UILabel!
    @IBOutlet weak var roomLowLabel: UILabel!
    @IBOutlet weak var itemHighLabel: UILabel!
    @IBOutlet weak var itemLowLabel: UILabel!
    
    // MARK: -Properties
    var viewModel: ReportViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ReportViewModel(delegate: self)
        
    }
    
    private func updateUI() {
       self.totalValueLabel.text = "\(viewModel.calculateNumberOfItems()) items totaling $\(viewModel.calculateTotalValue())"
        
        if let unwrappedItemHigh = viewModel.calculateItemHigh() {
            self.itemHighLabel.text = "\(unwrappedItemHigh.itemName),   $\(unwrappedItemHigh.valuePrice)"
        }
        
        if let unwrappedItemLow = viewModel.calculateItemLow() {
            self.itemLowLabel.text = "\(unwrappedItemLow.itemName),   $\(unwrappedItemLow.valuePrice)"
        }
        
        if let unwrappedHighestCollection = viewModel.calculateRoomHigh() {
            self.roomHighLabel.text = "\(unwrappedHighestCollection.name),   $\(unwrappedHighestCollection.value)"
        }
        
        if let unwrappedLowestCollection = viewModel.calculateRoomLow() {
            self.roomLowLabel.text = "\(unwrappedLowestCollection.name),   $\(unwrappedLowestCollection.value)"
        }
    }
}

extension ReportViewController: ReportViewModelDelegate {
    func reportHasData() {
        updateUI()
    }
}

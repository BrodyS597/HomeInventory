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
        viewModel = ReportViewModel()
        updateUI()
    }
    
    private func updateUI() {
        self.totalValueLabel.text = "\(viewModel.calculateNumberOfItems()) items totaling $\(viewModel.calculateTotalValue())"
        
        guard let unwrappedItemHigh = viewModel.calculateItemHigh() else { return }
        self.itemHighLabel.text = "\(unwrappedItemHigh.itemName),   $\(unwrappedItemHigh.valuePrice)"
        
        guard let unwrappedItemLow = viewModel.calculateItemLow() else { return }
        self.itemLowLabel.text = "\(unwrappedItemLow.itemName),   $\(unwrappedItemLow.valuePrice)"
        
        guard let unwrappedHighestCollection = viewModel.calculateRoomHigh() else { return }
        self.roomHighLabel.text = "\(unwrappedHighestCollection.name),   $\(unwrappedHighestCollection.value)"
        
        guard let unwrappedLowestCollection = viewModel.calculateRoomLow() else { return }
        self.roomLowLabel.text = "\(unwrappedLowestCollection.name),   $\(unwrappedLowestCollection.value)"
    }
}

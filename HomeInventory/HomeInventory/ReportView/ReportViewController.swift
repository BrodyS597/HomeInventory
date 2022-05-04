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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel = ReportViewModel(delegate: self)
    }
    
    @IBAction func CSVButtonTapped(_ sender: Any) {
        print("Exporting as CSV")
        //CSV File Name
        let file_name = "My Home Inventory.csv"
        // This is where the file will temporarily be saved to the device
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(file_name)
        //Column titles
        var csvHead = "Collection, Item, Model, Serial #, Purchase Price, Value Price, Purchase Date, Category, Notes\n"
        guard let collections = viewModel.collections else { return }
        for collection in collections {
            //csvHead.append("\(collection.name)")
            for item in collection.items {
                csvHead.append("\(collection.name),\(item.itemName),\(item.model),\(item.serialNumber),\(item.purchasePrice),\(item.valuePrice),\(item.purchaseDate),\(item.itemCategory),\(item.notes)\n")
            }
        }
        do {
            try csvHead.write(to: path!, atomically: true, encoding: .utf8)
            let exportSheet = UIActivityViewController(activityItems: [path as Any], applicationActivities: nil)
            self.present(exportSheet, animated: true, completion: nil)
            print("Exported")
        } catch {
            print("Error exporting")
        }
    }
    
    private func updateUI() {
        self.totalValueLabel.text = "\(viewModel.calculateNumberOfItems()) items totaling $\(viewModel.calculateTotalValue())"
        
        if let unwrappedItemHigh = viewModel.calculateItemHigh() {
            self.itemHighLabel.text = "\(unwrappedItemHigh.itemName) - $\(unwrappedItemHigh.valuePrice)"
        }
        
        if let unwrappedItemLow = viewModel.calculateItemLow() {
            self.itemLowLabel.text = "\(unwrappedItemLow.itemName) - $\(unwrappedItemLow.valuePrice)"
        }
        
        if let unwrappedHighestCollection = viewModel.calculateRoomHigh() {
            self.roomHighLabel.text = "\(unwrappedHighestCollection.name) - $\(unwrappedHighestCollection.value)"
        }
        
        if let unwrappedLowestCollection = viewModel.calculateRoomLow() {
            self.roomLowLabel.text = "\(unwrappedLowestCollection.name) - $\(unwrappedLowestCollection.value)"
        }
    }
}

extension ReportViewController: ReportViewModelDelegate {
    func reportHasData() {
        updateUI()
    }
}

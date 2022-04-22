//
//  HomeAddCellViewController.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/21/22.
//

import Foundation
import UIKit

class HomeAddCellViewController: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "HomeAddCellView", bundle: nil)
    }
}

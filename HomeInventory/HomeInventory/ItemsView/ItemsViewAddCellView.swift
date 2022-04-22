//
//  ItemsViewAddCellView.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/21/22.
//

import Foundation
import UIKit

class ItemsViewAddCellView: UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        //initialization code
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ItemsViewAddCell", bundle: nil)
    }
}

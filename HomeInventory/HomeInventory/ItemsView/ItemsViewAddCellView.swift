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
        contentView.layer.borderWidth = 5
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.cornerRadius = contentView.frame.height / 10
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ItemsViewAddCell", bundle: nil)
    }
}

//
//  ItemsViewCellCollectionViewCell.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/10/22.
//

import UIKit

class ItemsViewCellCollectionViewCell: UICollectionViewCell {
    
    // MARK: -IBoutlets
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        
    }
    
    public func configure(with image: UIImage) {
        itemImageView.image = image
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "", bundle: nil)
    }
}

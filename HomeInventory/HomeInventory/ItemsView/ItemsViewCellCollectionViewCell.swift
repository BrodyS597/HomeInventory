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
        super.awakeFromNib()
        
    }
    
    public func configure(with name: String) { // image: UIImage
        //itemImageView.image = image
        cellLabel.text = name
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "", bundle: nil)
    }
}

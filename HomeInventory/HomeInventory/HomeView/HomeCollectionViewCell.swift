//
//  HomeCollectionViewCell.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/10/22.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    // MARK: -IBOutlets
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //initialization code
    }
    
    public func configure(with name: String) { //image: UIImage, 
//groupImageView.image = image
        cellLabel.text = name
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "", bundle: nil)
    }
}

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
    }
    
    override func prepareForReuse() {
        groupImageView.image = nil
        cellLabel.text = nil
    }
    
    public func configure(with collection: Collection) {
        fetchImages(collection: collection)
        cellLabel.text = collection.name
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "", bundle: nil)
    }
    
    func fetchImages(collection: Collection) {        
        FireBaseStorageController().loadImageFromCollection(fromCollection: collection) { result in
            switch result {
            case .success(let image):
                self.groupImageView.image = image
                
            case.failure(let error):
                print(error)
                self.groupImageView.image = nil
            }
        }
    }
    
}

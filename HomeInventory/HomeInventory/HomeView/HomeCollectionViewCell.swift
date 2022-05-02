//
//  HomeCollectionViewCell.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/10/22.
//

import UIKit

protocol HomeCollectionViewCellDelegate {
    func presentAlertToDelete(collection: Collection)
}

class HomeCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    // MARK: -IBOutlets
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    var collection: Collection?
    var delegate: HomeCollectionViewCellDelegate?
    
    override func prepareForReuse() {
        groupImageView.image = nil
        cellLabel.text = nil
    }
    
    public func configure(with collection: Collection) {
        fetchImages(collection: collection)
        cellLabel.text = collection.name
        self.collection = collection
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
        setupLongGestureRecognizerOnCell()
    }
    
    private func setupLongGestureRecognizerOnCell() {
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressedGesture.minimumPressDuration = 0.5
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        self.contentView.addGestureRecognizer(longPressedGesture)
    }
    
    @objc func handleLongPress() {
        guard let collection = collection else { return }
        delegate?.presentAlertToDelete(collection: collection)
    }
    
}

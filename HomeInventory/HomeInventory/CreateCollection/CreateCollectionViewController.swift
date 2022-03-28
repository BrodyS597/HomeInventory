//
//  CreateCollectionViewController.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/21/22.
//

import Foundation
import UIKit

class CreateCollectionViewController: UIViewController {
    
    // MARK: -IBOutlets
    @IBOutlet weak var collectionImageView: UIImageView!
    @IBOutlet weak var collectionNameTextField: UITextField!
    
    
    // MARK: -Properties
    var viewModel: CreateCollectionVCModel!
    var itemViewModel: ItemVCModel!
    
    override func viewDidLoad() {
        collectionImageView.contentMode = .scaleAspectFit
        collectionImageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(collectionImageViewTapped))
        collectionImageView.addGestureRecognizer(tapGesture)
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: -IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let collectionName = collectionNameTextField.text,
              !collectionName.isEmpty
        else { return }
        let collection = Collection(name: collectionName, items: [])
        
        viewModel.collection = collection
        viewModel.saveCollection(image: collectionImageView.image)
        
        let storyboard = UIStoryboard(name: "ItemsView", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "ItemsViewController") as? ItemsViewController else { return }
        viewController.viewModel = ItemVCModel(collection: collection, delegate: viewController)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func discardButtonTapped(_ sender: Any) {
        //set all fields to empty and delete collection
    }
    
    @objc func collectionImageViewTapped() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
        //picker
    }
    
    // MARK: -helper Func
    private func updateUI() {
        if let collection = viewModel.collection {
            self.collectionNameTextField.text = collection.name
            //self.collectionImageView.image = collection.collectionPhotoURL
            
        }
    }
}

extension CreateCollectionViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        self.collectionImageView.image = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

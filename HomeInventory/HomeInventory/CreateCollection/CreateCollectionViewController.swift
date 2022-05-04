//
//  CreateCollectionViewController.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/21/22.
//

import Foundation
import UIKit

class CreateCollectionViewController: UIViewController, UITextFieldDelegate {
    
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
        
        if collectionImageView.image == UIImage(systemName: "camera.shutter.button") {
            let alertController = UIAlertController(title: "No photo selected", message: "You have not selected an image for this collection. An image cannot be set after creation. Would you like to continue?", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Yes", style: .default) { _ in
                self.viewModel.collection = collection
                self.viewModel.saveCollection(image: nil)
                self.navigationController?.popViewController(animated: true)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(cancelAction)
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true)
        } else {
            viewModel.collection = collection
            viewModel.saveCollection(image: self.collectionImageView.image)
            navigationController?.popViewController(animated: true)
        }
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
    }
    
    // MARK: -helper Func
    private func updateUI() {
        if let collection = viewModel.collection {
            self.collectionNameTextField.text = collection.name
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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

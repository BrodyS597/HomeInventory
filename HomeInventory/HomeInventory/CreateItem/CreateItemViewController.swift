//
//  CreateItemViewController.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/10/22.
//

import UIKit

class CreateItemViewController: UIViewController {

    // MARK: -IBOutlets
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var serialTextField: UITextField!
    @IBOutlet weak var purchasePriceTextField: UITextField!
    @IBOutlet weak var valuePriceTextField: UITextField!
    @IBOutlet weak var purchaseDateTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextView!
    
    // MARK: -Properties
    var viewModel: CreateItemVCModel!
    
    override func viewDidLoad() {
        itemImageView.contentMode = .scaleAspectFit
        itemImageView.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(itemImageViewTapped))
        itemImageView.addGestureRecognizer(tapGesture)
        super.viewDidLoad()
        updateUI()
    }
    
    // MARK: -IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        //make sure name field not empty
    }
    @IBAction func discardButtonTapped(_ sender: Any) {
        //set all fields to empty and delete item/group
    }
    
    @objc func itemImageViewTapped() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
        //picker
    }
    
    // MARK: -helper Func
    private func updateUI() {
        if let item = viewModel.item {
            self.itemNameTextField.text = item.itemName
            //self.itemImageView.image = item.itemPhotoURL
            self.modelTextField.text = item.model
            self.serialTextField.text = item.serialNumber
            let purchasePriceString = String(item.purchasePrice)
            self.purchasePriceTextField.text = purchasePriceString
            let valuePriceString = String(item.valuePrice)
            self.valuePriceTextField.text = valuePriceString
            let purchaseDateString = String(item.purchaseDate)
            self.purchaseDateTextField.text = purchaseDateString
            self.categoryTextField.text = item.itemCategory
            self.notesTextField.text = item.notes
        }
    }
}

extension CreateItemViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //dismiss, set image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

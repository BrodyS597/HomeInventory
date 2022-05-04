//
//  CreateItemViewController.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/10/22.
//

import UIKit

class CreateItemViewController: UIViewController, UITextFieldDelegate {
    
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
    var viewModel: CreateItemVCModel?
    var itemViewModel: ItemVCModel!
    
    override func viewDidLoad() {
        itemImageView.contentMode = .scaleAspectFit
        itemImageView.isUserInteractionEnabled = true
        navigationController?.navigationBar.backgroundColor = .clear
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(itemImageViewTapped))
        itemImageView.addGestureRecognizer(tapGesture)
        super.viewDidLoad()
        fillItemDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = .black
    }
    
    // MARK: -IBActions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let itemName = itemNameTextField.text,
              !itemName.isEmpty,
              let itemPhotoURL = itemImageView.image,
              let model = modelTextField.text,
              let serialNumber = serialTextField.text,
              let purchasePrice = purchasePriceTextField.text,
              let valuePrice = valuePriceTextField.text,
              let purchaseDate = purchaseDateTextField.text,
              let itemCategory = categoryTextField.text,
              let notes = notesTextField.text,
              let collection = viewModel?.collection
        else { return }
        if itemImageView.image == UIImage(systemName: "camera.shutter.button") {
            viewModel?.saveItem(toCollection: collection, itemName: itemName, itemPhotoURL: nil, model: model, serialNumber: serialNumber, purchasePrice: Double(purchasePrice) ?? 0.00, valuePrice: Double(valuePrice) ?? 0.00, purchaseDate: purchaseDate, itemCategory: itemCategory, notes: notes)
            self.navigationController?.popViewController(animated: true)
        } else {
            viewModel?.saveItem(toCollection: collection, itemName: itemName, itemPhotoURL: itemPhotoURL, model: model, serialNumber: serialNumber, purchasePrice: Double(purchasePrice) ?? 0.00, valuePrice: Double(valuePrice) ?? 0.00, purchaseDate: purchaseDate, itemCategory: itemCategory, notes: notes)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func discardButtonTapped(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Are you sure?", message: "The deletion cannot be undone", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "DELETE", style: .destructive) { _ in
            self.viewModel?.deleteItem()
            self.navigationController?.popViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true)
    }
    
    @objc func itemImageViewTapped() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    // MARK: -helper Func
    private func fillItemDetails() {
        if let item = viewModel?.item {
            self.itemNameTextField.text = item.itemName
            self.modelTextField.text = item.model
            self.serialTextField.text = item.serialNumber
            self.purchasePriceTextField.text = String(item.purchasePrice)
            self.valuePriceTextField.text = String(item.valuePrice)
            self.purchaseDateTextField.text = String(item.purchaseDate)
            self.categoryTextField.text = item.itemCategory
            self.notesTextField.text = item.notes
            
            viewModel?.fetchImage { image in
                if let image = image {
                    self.itemImageView.image = image
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension CreateItemViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
        self.itemImageView.image = image
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

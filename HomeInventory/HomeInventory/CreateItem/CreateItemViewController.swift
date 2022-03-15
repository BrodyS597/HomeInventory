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
    @IBOutlet weak var purchasePriceTextFIeld: UITextField!
    @IBOutlet weak var valuePriceTextField: UITextField!
    @IBOutlet weak var purchaseDateTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextView!
    
    // MARK: -Properties
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: -IBActions
    @IBAction func returnHomeButtonTapped(_ sender: Any) {
        //segue to home view
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        //make sure name field not empty
    }
    @IBAction func clearButtonTapped(_ sender: Any) {
        //set all fields to empty and delete item/group
    }
    
    
    @objc func itemImageViewTapped() {
        //picker
    }
    
    // MARK: -helper Func
    private func updateUI() {
        
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

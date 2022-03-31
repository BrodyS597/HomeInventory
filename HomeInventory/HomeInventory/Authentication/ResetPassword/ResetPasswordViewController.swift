//
//  ResetPasswordViewController.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/10/22.
//

import UIKit
import Firebase
import FirebaseAuth
import simd

class ResetPasswordViewController: UIViewController {
    
    // MARK: -IBOutlets
    @IBOutlet weak var emailAddressTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: -IBActions
    @IBAction func sendPasswordRestButtonTapped(_ sender: Any) {
    }
    
    @IBAction func returnToLoginButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "login")
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }
    
    func sendPasswordReset(){
        guard let emailAddress = emailAddressTextField.text else { return }
        Auth.auth().sendPasswordReset(withEmail: emailAddress) { error in
            if let error = error {
                print(error)
                return
            }
        }
    }
    
    func checkUserInfo(){
        
    }
    
}

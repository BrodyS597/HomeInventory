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
        sendPasswordReset()
        
        let alertController = UIAlertController(title: "If an account is registered to that email address, we will send you an email", message: "Please check your email for further instructions on resetting your password", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Confirm and return to login", style: .default , handler: { (action: UIAlertAction!) in
            //confirm logic
            self.returnToLogin()
        }))
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func returnToLoginButtonTapped(_ sender: Any) {
        returnToLogin()
    }
    
    func sendPasswordReset() {
        guard let emailAddress = emailAddressTextField.text else { return }
        Auth.auth().sendPasswordReset(withEmail: emailAddress) { error in
            if let error = error {
                print(error)
                return
            }
        }
    }
    
    func returnToLogin() {
        let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "login")
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }
}

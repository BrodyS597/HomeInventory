//
//  SignUpViewController.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/10/22.
//

import UIKit
import Firebase
import FirebaseAuth
import simd

class SignUpViewController: UIViewController {
    
    // MARK: -IBOutlets
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: -IBActions
    @IBAction func signUpButtonTapped(_ sender: Any) {
        if emailAddressTextField.text?.isEmpty == true {
            print("No text entered in email field")
            let alertController = UIAlertController(title: "Error: Email Address field is empty", message: "Please enter a valid Email Address", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        if passwordTextField.text?.isEmpty == true {
            print("No text entered in password field")
            let alertController = UIAlertController(title: "Error: Password field is empty", message: "Please enter a valid password", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let password = passwordTextField.text else { return }
        if validatePassword(password) == false {
            let alertController = UIAlertController(title: "Password is invalid", message: " Passwords must contain a minimum of 6 characters and no spaces. Please try again.", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
        }
        signUp()
    }
    
    @IBAction func returnToLoginButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "login")
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }
    
    func signUp() {
        guard let emailAddress = emailAddressTextField.text,
              let password = passwordTextField.text else { return }
        Auth.auth().createUser(withEmail: emailAddress, password: password) { authResult, error in
            if let error = error {
                print(error)
                return
            }
            
            guard let user = authResult?.user else { return }
            UserDefaults.standard.set(user.uid, forKey: "uid")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "tabCon") as? UITabBarController else { return }
            tabBarController.modalPresentationStyle = .overFullScreen
            self.present(tabBarController, animated: true)
        }
    }
    
    func validatePassword(_ password: String) -> Bool {
        //At least 8 characters
        if password.count < 6 {
            return false
        }
        //No whitespace characters
        if password.range(of: #"\s+"#, options: .regularExpression) != nil {
            return false
        }
        return true
    }
}

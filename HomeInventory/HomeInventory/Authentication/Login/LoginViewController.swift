//
//  LoginViewController.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/10/22.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: -IBOutlets
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
// MARK: -IBActions
    @IBAction func loginButtonTapped(_ sender: Any) {
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SignUpView", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "signUp")
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }
    
    @IBAction func forgotPasswordButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "ResetPasswordView", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "resetPassword")
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }
    
    func checkUserInfo() {
      //ensure the email ecists for a user and the password is valid
        //needs closure for either event, user exists or not.
    }
    
    func segueToHomeView() {
        
    }
    
    func segueToSignUp() {
        
    }
}

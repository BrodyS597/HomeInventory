//
//  SignUpViewController.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/10/22.
//

import UIKit

class SignUpViewController: UIViewController {

    // MARK: -IBOutlets
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: -IBActions
    @IBAction func signUpButtonTapped(_ sender: Any) {
    }
    @IBAction func returnToLoginButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "login")
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }
    
    func signUp(){
        
    }
}

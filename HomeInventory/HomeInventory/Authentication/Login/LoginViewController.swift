//
//  LoginViewController.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/10/22.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    // MARK: -IBOutlets
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
              let uid = user.uid
                UserDefaults.standard.set(uid, forKey: "uid")
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    // MARK: -IBActions
    @IBAction func loginButtonTapped(_ sender: Any) {
        if let emailAddress = emailAddressTextField.text, !emailAddress.isEmpty,
           let password = passwordTextField.text, !password.isEmpty {
            Auth.auth().signIn(withEmail: emailAddress, password: password) { result, error in
                switch result {
                case .none:
                    let alertController = UIAlertController(title: "Account not found", message: "Please check your username and password", preferredStyle: .alert)
                    let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(confirmAction)
                    self.present(alertController, animated: true, completion: nil)
                case .some(let userDetails):
                    print("Welcome back!", userDetails.user.email!)
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "tabCon") as? UITabBarController else { return }
                    tabBarController.modalPresentationStyle = .overFullScreen
                    self.present(tabBarController, animated: true)
                }
            }
        }
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
        if Auth.auth().currentUser != nil {
            print(Auth.auth().currentUser?.uid)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "tabCon")
            viewController.modalPresentationStyle = .overFullScreen
            present(viewController, animated: true)
        }
    }
    
    func segueToHomeView() {
        
    }
}

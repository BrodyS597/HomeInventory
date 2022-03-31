//
//  LoginViewController.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/10/22.
//

import UIKit
import Firebase
import FirebaseAuth
import AuthenticationServices
import CryptoKit

class LoginViewController: UIViewController {
    
    // Unhashed nonce.
    fileprivate var currentNonce: String?
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
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
    
    @IBAction func signInWithAppleTapped(_ sender: Any) {
        performSignInWithApple()
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
    
    func performSignInWithApple() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.email]
        self.currentNonce = randomNonceString()
        request.nonce = sha256(currentNonce!)
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        
        authorizationController.performRequests()
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            UserDefaults.standard.set(appleIDCredential.user, forKey: "appleAuthorizedUserIdKey")
            
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            
            Auth.auth().signIn(with: credential) { (authDataResult, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                
                if let user = authDataResult?.user {
                    print("signed in as \(user.uid), email: \(user.email ?? "unknown email")")
                    
                    switch authDataResult {
                    case .none:
                        let alertController = UIAlertController(title: "Account not found", message: "Please check your username and password", preferredStyle: .alert)
                        let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                        alertController.addAction(confirmAction)
                        self.present(alertController, animated: true, completion: nil)
                    case .some(let userDetails):
                        print("Welcome back!", userDetails.user.email!)
                        
                        //segue to home
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "tabCon") as? UITabBarController else { return }
                        tabBarController.modalPresentationStyle = .overFullScreen
                        self.present(tabBarController, animated: true)
                    }
                }
            }
        }
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

// MARK: - NONCE
// used and created once to avoid replay attacks

private func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
  var result = ""
  var remainingLength = length

  while remainingLength > 0 {
    let randoms: [UInt8] = (0 ..< 16).map { _ in
      var random: UInt8 = 0
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
      if errorCode != errSecSuccess {
        fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
      }
      return random
    }

    randoms.forEach { random in
      if remainingLength == 0 {
        return
      }

      if random < charset.count {
        result.append(charset[Int(random)])
        remainingLength -= 1
      }
    }
  }
  return result
}


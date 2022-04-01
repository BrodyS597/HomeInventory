//
//  AccountViewController.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/11/22.
//

import UIKit
import FirebaseAuth
import MessageUI

class AccountViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var userEmailAddressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        if let user = Auth.auth().currentUser {
            if let emailAddress = user.email {
                self.userEmailAddressLabel.text = "Signed in with: \(emailAddress)"
            }
        }
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        let logoutAlert = UIAlertController(title: "Are you sure you wish to logout?", message: "This will return you to the login screen", preferredStyle: UIAlertController.Style.alert)
        logoutAlert.addAction(UIAlertAction(title: "Confirm", style: .destructive , handler: { (action: UIAlertAction!) in
            //confirm logic
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
            let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "login")
            viewController.modalPresentationStyle = .overFullScreen
            self.present(viewController, animated: true)
        }))
        
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            //cancel logic
            return }))
        
        present(logoutAlert, animated: true, completion: nil)
    }
    
    @IBAction func contactUsButtonTapped(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["BWS.HomeInventory@gmail.com"])
            mail.setSubject("")
            mail.setMessageBody("", isHTML: true)
            
            //add attachment
            if let filePath = Bundle.main.path(forResource: "", ofType: "") {
                if let data = NSData(contentsOfFile: filePath) {
                    mail.addAttachmentData(data as Data,
                                           mimeType: "" , fileName: "")
                }
            }
            present(mail, animated: true)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

//
//  AccountViewController.swift
//  HomeInventory
//
//  Created by Brody Sears on 3/11/22.
//

import UIKit
import FirebaseAuth

class AccountViewController: UIViewController {

    @IBOutlet weak var userEmailAddressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

        // Do any additional setup after loading the view.
    }
    
    func updateUI() {
        if let user = Auth.auth().currentUser {
            if let emailAddress = user.email {
            self.userEmailAddressLabel.text = "Signed in with: \(emailAddress)"
            }
        }
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
    }
    
    @IBAction func contactUsButtonTapped(_ sender: Any) {
    }
    
    
}

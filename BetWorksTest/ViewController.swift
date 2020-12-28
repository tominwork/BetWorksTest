//
//  ViewController.swift
//  BetWorksTest
//
//  Created by Thomas Varghese on 2020-12-24.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    private let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        let success = loginViewModel.login(withUserName: userName.text!, andPassword: password.text!)
        if !success {
            let alert = loginViewModel.showAlert(message: "Invalid Credentials.")
            present(alert, animated: true)
        }
        else {
            performSegue(withIdentifier: "welcomeVCSegue", sender: sender)
        }
    }
}


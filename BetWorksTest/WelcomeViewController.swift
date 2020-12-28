//
//  WelcomeViewController.swift
//  BetWorksTest
//
//  Created by Thomas Varghese on 2020-12-27.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userName.text = User.shared.userName?.uppercased()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

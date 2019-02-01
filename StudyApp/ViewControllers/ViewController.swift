//
//  ViewController.swift
//  StudyApp
//
//  Created by RAK on 31/01/2019.
//  Copyright © 2019 RAK. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        checkUserIsLoggedIn()
        
    }
    
    func checkUserIsLoggedIn() {
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(presentLoginViewController), with: nil, afterDelay: 0)
        }
    }
        
    


}

extension UIViewController {
    @objc func presentLoginViewController() {
        if let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "loginViewController") {
            let navigationController = UINavigationController(rootViewController: loginViewController)
            present(navigationController, animated: true, completion: nil)
        }
    }
}

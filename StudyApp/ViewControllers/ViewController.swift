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
        print("checkUserInLoggedIn")
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(presentLoginViewController), with: nil, afterDelay: 0)
        }
        
    }
        
    @objc func presentLoginViewController() {
        print("presentLoginViewController")
        performSegue(withIdentifier: "showLoginViewController", sender: self)
    }


}


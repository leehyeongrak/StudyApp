//
//  LoginViewController.swift
//  StudyApp
//
//  Created by RAK on 31/01/2019.
//  Copyright © 2019 RAK. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func tappedSignUpButton(_ sender: UIButton) {
        
    }
    @IBAction func tappedSignInButton(_ sender: UIButton) {
        guard let emailText = emailTextField.text, let passwordText = passwordTextField.text else {
            return
        }
        
        if emailText == "" || passwordText == "" {
            print("Invalid input")
        } else {
            Auth.auth().signIn(withEmail: emailText, password: passwordText) { (user, error) in
                if error != nil {
                    print(error)
                }
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

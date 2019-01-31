//
//  SignUpViewController.swift
//  StudyApp
//
//  Created by RAK on 31/01/2019.
//  Copyright © 2019 RAK. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    
    @IBAction func tappedRegisterButton(_ sender: UIButton) {
        registerUser()
    }
    
    
    func registerUser() {
        guard let nameText = nameTextField.text, let emailText = emailTextField.text, let passwordText = passwordTextField.text, let passwordConfirmText = passwordConfirmTextField.text else {
            return
        }
        
        if nameText == "" || emailText == "" || passwordText == "" || passwordConfirmText == "" {
            print("Invalid input")
        } else {
            if passwordText == passwordConfirmText {
                Auth.auth().createUser(withEmail: emailText, password: passwordText) { (user, error) in
                    if error != nil {
                        print(error)
                        return
                    }
                    
                    self.navigationController?.popViewController(animated: true)
                    
                    
                    
                    
                }
            } else {
                print("Password not correspond")
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

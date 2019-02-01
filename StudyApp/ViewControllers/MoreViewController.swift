//
//  MoreViewController.swift
//  StudyApp
//
//  Created by RAK on 01/02/2019.
//  Copyright © 2019 RAK. All rights reserved.
//

import UIKit
import Firebase

class MoreViewController: UIViewController {

    @IBAction func tappedSignOutButton(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            perform(#selector(presentLoginViewController), with: nil, afterDelay: 0)
        } catch {
            print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setTitle()
    }
    
    func setTitle() {
        let name = Auth.auth().currentUser?.email
        navigationItem.title = name
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

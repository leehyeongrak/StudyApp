//
//  RecruitPostWriteViewController.swift
//  StudyApp
//
//  Created by RAK on 11/02/2019.
//  Copyright © 2019 RAK. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RecruitPostWriteViewController: UIViewController {

    var newPost: GroupRecruitPost?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var hashtagsTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    
    @IBAction func tappedPostButton(_ sender: UIButton) {
        guard let user = Auth.auth().currentUser, let titleText = titleTextField.text, let hashtagsText = hashtagsTextField.text, let contentText = contentTextField.text else { return }
        
        if titleText == "" || hashtagsText == "" || contentText == "" {
            print("필드 채울것")
            return
        }
        
        let timestamp = Int(NSDate().timeIntervalSince1970)

        let values: [String: Any] = ["uid": user.uid, "title": titleText, "content": contentText, "hashtags": hashtagsText, "timestamp": timestamp]
        
        let ref = Database.database().reference().child("groupRecruitPosts")
        let childRef = ref.childByAutoId()
        
        childRef.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error)
                return
            }
            print("successssssss")
            self.navigationController?.popViewController(animated: true)
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

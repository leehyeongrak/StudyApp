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

class RecruitPostWriteViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var hashtagsTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    
    @IBAction func tappedPostButton(_ sender: UIButton) {
        guard let user = Auth.auth().currentUser, let titleText = titleTextField.text, let hashtagsText = hashtagsTextField.text, let contentText = contentTextField.text else { return }
        
        if titleText == "" || hashtagsText == "" || contentText == "" {
            let alert = UIAlertController(title: "", message: "빈칸을 채워주세요🤗", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            
            return
        }
        
        let timestamp = Int(NSDate().timeIntervalSince1970)

        let values: [String: Any] = ["uid": user.uid, "title": titleText, "content": contentText, "hashtags": hashtagsText, "timestamp": timestamp, "maxCount": 5, "currentCount": 1]
        
        let ref = Database.database().reference().child("groupRecruitPosts")
        let childRef = ref.childByAutoId()
        
        childRef.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error)
                return
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.delegate = self
        hashtagsTextField.delegate = self
        contentTextField.delegate = self
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

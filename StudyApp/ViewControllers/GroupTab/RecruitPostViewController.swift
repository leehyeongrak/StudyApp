//
//  RecruitPostViewController.swift
//  StudyApp
//
//  Created by RAK on 13/02/2019.
//  Copyright © 2019 RAK. All rights reserved.
//

import UIKit
import FirebaseDatabase

class RecruitPostViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var post: GroupRecruitPost?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var isRecruitingLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hashtagsCollectionView: UICollectionView!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hashtagsCollectionView.delegate = self
        hashtagsCollectionView.dataSource = self
        
        if post != nil {
            setPostInfoToOutlet(post: post!)
        }
        
        profileImageView.layer.cornerRadius = 24
        profileImageView.layer.masksToBounds = true
        
    }
    
    private func setPostInfoToOutlet(post: GroupRecruitPost) {
        titleLabel.text = post.postTitle
        nameLabel.text = post.postWriterUID
        contentLabel.text = post.postContent
        isRecruitingLabel.text = "모집중"
        
        Database.database().reference().child("users").child((post.postWriterUID)!).observe(.value) { (snapshot) in
            if let dictionary = snapshot.value as? [String: Any] {
                self.nameLabel.text = dictionary["name"] as? String
            }
        }
        
        if let seconds = Double(exactly: post.timestamp!) {
            let timestampDate = NSDate(timeIntervalSince1970: seconds)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm:ss"
            let date = dateFormatter.string(from: timestampDate as Date)
            
            self.timestampLabel.text = date
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let count = post?.hashtags?.count else { return 0 }
        
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hashtagCell", for: indexPath) as? GroupRecruitPostHashtagCell else { return UICollectionViewCell() }
        
        if let text = post?.hashtags?[indexPath.item] {
            cell.hashtag = text
        }
        
        return cell
    }
    
}

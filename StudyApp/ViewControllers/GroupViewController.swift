//
//  GroupViewController.swift
//  StudyApp
//
//  Created by RAK on 31/01/2019.
//  Copyright © 2019 RAK. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class GroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {

    let identifier = "groupRecruitPostCell"
//    var storedOffsets = [Int: CGFloat]()
    var posts: Array<GroupRecruitPost> = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchPosts()
        // Do any additional setup after loading the view.
    }
    
    private func fetchPosts() {
        
        let ref = Database.database().reference().child("groupRecruitPosts").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: Any] {
                
                let post = GroupRecruitPost()
                
                post.postTitle = dictionary["title"] as? String
                post.postContent = dictionary["content"] as? String
                post.postWriterUID = dictionary["uid"] as? String
                post.timestamp = dictionary["timestamp"] as? Int
                post.hashtags = self.parsingHashtags(hashtagsText: dictionary["hashtags"] as? String)
                post.recruitMaxCount = dictionary["maxCount"] as? Int
                post.recruitCurrentCount = dictionary["currentCount"] as? Int
                self.posts.append(post)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }, withCancel: nil)
        
    }
    
    private func parsingHashtags(hashtagsText: String?) -> Array<String> {
        guard let hashtagsArray = hashtagsText?.components(separatedBy: " ") else { return [] }
        
        return hashtagsArray
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? GroupRecruitPostCell else {
            return UITableViewCell()
        }
        cell.post = posts[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? GroupRecruitPostCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
//        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
//    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        guard let tableViewCell = cell as? GroupRecruitPostCell else { return }
//
//        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let number = posts[collectionView.tag].hashtags?.count else { return 0 }
        return number
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hashtagCell", for: indexPath) as? GroupRecruitPostHashtagCell else { return UICollectionViewCell() }
        if let text = posts[collectionView.tag].hashtags?[indexPath.item] {
            cell.hashtag = text
        }
        
        return cell
    }

}

class GroupRecruitPostCell: UITableViewCell {
    
    var post: GroupRecruitPost? {
        didSet {
            self.titleLabel.text = post?.postTitle
            
            Database.database().reference().child("users").child((post?.postWriterUID)!).observe(.value) { (snapshot) in
                if let dictionary = snapshot.value as? [String: Any] {
                    self.nameLabel.text = dictionary["name"] as? String
                }
            }
            
            if let seconds = Double(exactly: (post?.timestamp)!) {
                let timestampDate = NSDate(timeIntervalSince1970: seconds)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm:ss"
                let date = dateFormatter.string(from: timestampDate as Date)
                
                self.timestampLabel.text = date
            }
            
            if let currentCount = post?.recruitCurrentCount, let maxCount = post?.recruitMaxCount {
                self.countLabel.text = "(\(currentCount)/\(maxCount))"
            }
            
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    private var isBookmarked: Bool = false {
        didSet {
            if isBookmarked {
                bookmarkButton.backgroundColor = .yellow
            } else {
                bookmarkButton.backgroundColor = .white
            }
        }
    }
    
    @IBOutlet weak var hashtagsCollectionView: UICollectionView!
    
    @IBAction func TappedBookmarkButton(_ sender: UIButton) {
        self.isBookmarked = !isBookmarked
    }
    
    
    var collectionViewOffset: CGFloat {
        get {
            return hashtagsCollectionView.contentOffset.x
        }
        
        set {
            hashtagsCollectionView.contentOffset.x = newValue
        }
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        hashtagsCollectionView.delegate = dataSourceDelegate
        hashtagsCollectionView.dataSource = dataSourceDelegate
        hashtagsCollectionView.tag = row
        hashtagsCollectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
}

class GroupRecruitPostHashtagCell: UICollectionViewCell {
    
    var hashtag: String? {
        didSet {
            self.hashtagLabel.text = hashtag
        }
    }
    
    @IBOutlet weak var hashtagLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .lightGray
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true


    }
    
}

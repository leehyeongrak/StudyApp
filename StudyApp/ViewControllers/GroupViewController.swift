//
//  GroupViewController.swift
//  StudyApp
//
//  Created by RAK on 31/01/2019.
//  Copyright © 2019 RAK. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {

    let identifier = "groupRecruitPostCell"
    var storedOffsets = [Int: CGFloat]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.register(GroupRecruitPostCell.self, forCellReuseIdentifier: identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? GroupRecruitPostCell else {
            return UITableViewCell()
        }
        cell.post = GroupRecruitPost()
        
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
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hashtagCell", for: indexPath) as? GroupRecruitPostHashtagCell else { return UICollectionViewCell() }
        
        return cell
    }

}

class GroupRecruitPostCell: UITableViewCell {
    
    var post: GroupRecruitPost? {
        didSet {
            self.titleLabel.text = "스터디그룹 모집게시물의 샘플입니다."
            self.nameLabel.text = "이형락"
            self.timestampLabel.text = "2019/02/07"
            self.countLabel.text = "1/5"
            post?.hashtags = ["iOS", "Swift"]
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var hashtagsCollectionView: UICollectionView!
    
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
    
    @IBOutlet weak var hashtagLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = .lightGray
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        hashtagLabel.textColor = .white
        hashtagLabel.text = "Tag"
    }
    
}

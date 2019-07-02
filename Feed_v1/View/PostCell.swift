//
//  File.swift
//  Feed_v1
//
//  Created by HungPB on 7/1/19.
//  Copyright © 2019 HungPB. All rights reserved.
//

import UIKit

protocol PostCellDelegate : class{
    func handleLike(cell : UITableViewCell)
    
    func handleShowProfile(cell : UITableViewCell)
}

class PostCell : UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.likeBtn.addTarget(self, action: #selector(likeTapped), for: .touchUpInside)
        self.avatarBtn.addTarget(self, action: #selector(avatarClicked), for: .touchUpInside)
        setupLayout()
    }
    
    @objc func likeTapped(){
        self.delegate?.handleLike(cell: self)
    }
    
    @objc func avatarClicked(){
        self.delegate?.handleShowProfile(cell: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var post: Post? {
        didSet {
            guard let post = post else {return}
            didSetPost(post: post)
        }
    }
    
    weak var delegate : PostCellDelegate?
    
    let avatarBtn : UIButton = {
        let btn = UIButton()
        btn.contentMode = .scaleAspectFit
        return btn
    }()
    
    let nameLabel : UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 2
        return lbl
    }()
    
    let statusLabel : UILabel = {
        let lbl = UILabel()
//        lbl.backgroundColor = .yellow
        lbl.numberOfLines = 3
        lbl.sizeToFit()
        lbl.font = UIFont.systemFont(ofSize: 9)
        return lbl
    }()
    
    let postImage : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        return img
    }()
    
    let likeBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "like"), for: .normal)
        return btn
    }()

    
    let likeLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 11)
        return lbl
    }()
    
    let commentBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "comment"), for: .normal)
        return btn
    }()
    
    let commentLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 11)
        return lbl
    }()
    
    var postImageHeightConstraint: NSLayoutConstraint!
    
    func didSetPost(post: Post){
        if let avatarImage = post.poster.avatar {
            self.avatarBtn.setImage(UIImage(named: avatarImage), for: .normal)
        }
        
        if let name = post.poster.name {
            let atributedText = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12)])
            
            guard let elapsedInterval = post.postTime?.timeAgoSinceDate() else {return}
            
            atributedText.append(NSAttributedString(string: "\n\(elapsedInterval)", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 9)]))
            self.nameLabel.attributedText = atributedText
        }
        
        self.statusLabel.text = post.statusText
        
        if let postImage = post.postImage {
            self.postImage.image = postImage
            self.postImageHeightConstraint.constant = 200
        }else{
            self.postImageHeightConstraint.constant = 0
        }
        
        self.likeLbl.text = "\(post.like)"
        
        self.commentLbl.text = "\(post.comment)"
    }
    
    func setupLayout(){
        self.addSubview(avatarBtn)
        self.addSubview(nameLabel)
        self.addSubview(statusLabel)
        self.addSubview(postImage)
        
        avatarBtn.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        postImage.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            avatarBtn.heightAnchor.constraint(equalToConstant: 35),
            avatarBtn.widthAnchor.constraint(equalToConstant: 35),
            avatarBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            avatarBtn.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            nameLabel.leadingAnchor.constraint(equalTo: avatarBtn.trailingAnchor, constant: 8),
            nameLabel.centerYAnchor.constraint(equalTo: avatarBtn.centerYAnchor),
            
//            statusLabel.heightAnchor.constraint(equalToConstant: 10),
            statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            statusLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            statusLabel.topAnchor.constraint(equalTo: avatarBtn.bottomAnchor, constant: 8),
            
            postImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            postImage.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 8),
            postImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            ])
        postImageHeightConstraint = postImage.heightAnchor.constraint(equalToConstant: 0)
        postImageHeightConstraint.isActive = true
        
        let likeStackView = UIStackView(arrangedSubviews: [likeBtn,likeLbl])
        likeStackView.spacing = 4
        
        let commentStackView = UIStackView(arrangedSubviews: [commentBtn,commentLbl])
        likeStackView.spacing = 4
        
        let reviewStackView = UIStackView(arrangedSubviews: [likeStackView,commentStackView])
        reviewStackView.distribution = .fillEqually
        reviewStackView.spacing = 10
        
        self.addSubview(reviewStackView)
        reviewStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            reviewStackView.heightAnchor.constraint(equalToConstant: 20),
            reviewStackView.widthAnchor.constraint(equalToConstant: 100),
            reviewStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            reviewStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            reviewStackView.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 4),
            ])
        
    }
    
    
}

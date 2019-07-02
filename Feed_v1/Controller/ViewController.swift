//
//  ViewController.swift
//  Feed_v1
//
//  Created by HungPB on 7/1/19.
//  Copyright © 2019 HungPB. All rights reserved.
//

import UIKit



class ViewController: UITableViewController {

    let cellId = "cell09121996"
    
    var posts = [Post]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.alwaysBounceVertical = true
        tableView.register(PostCell.self, forCellReuseIdentifier: cellId)
        navigationItem.title = "Feed"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "add")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(addNewPost))
        
        initData()
        
    }
    
    fileprivate func initData() {
        // Some data
        let poster = Poster(name: "Hiroshi", address: "Tokyo", birthdate: "28-05-1989", avatar: "avatar")
        let goodLunch = Post(poster: poster, statusText: "Good lunch, good food with my friends ^^\nGood lunch, good food with my friends ^^\nGood lunch, good food with my friends ^^" ,postImage: UIImage(named: "post_image"), createDate: Date())
        let lostCat = Post(poster: poster, statusText:"Anyone see my cat :(", postImage: nil, createDate: Date())
        
        posts.append(goodLunch)
        posts.append(lostCat)
    }
    
    
    @objc func addNewPost() {
        print("Adding new post...")
        let newPostVC = NewPostVC()
        newPostVC.delegate = self
        navigationController?.pushViewController(newPostVC, animated: true)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? PostCell{
            cell.delegate = self
            cell.post = posts[indexPath.row]
//            cell.didSetPost()
            return cell
        }
        return UITableViewCell()
    }
    

}

extension ViewController: PostCellDelegate{

    func handleLike(cell: UITableViewCell) {
        guard let indexPathTapped = tableView.indexPath(for: cell) else {return}
        let post = posts[indexPathTapped.row]
        let hasLiked = post.hasLiked
        posts[indexPathTapped.row].hasLiked = !hasLiked
        if posts[indexPathTapped.row].hasLiked {
            posts[indexPathTapped.row].like += 1
        }else{
            posts[indexPathTapped.row].like -= 1
        }
        self.tableView.reloadData()
    }
    
    func handleShowProfile(poster: Poster) {
        let profileVC = ProfileViewController()
        profileVC.poster = poster
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
}

extension ViewController: NewPostVCDelegate{
    func handleAddPost(post: Post) {
        self.posts.insert(post, at: 0)
        self.tableView.reloadData()
    }
}


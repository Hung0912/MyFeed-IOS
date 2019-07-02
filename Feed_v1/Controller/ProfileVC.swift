//
//  ProfileVC.swift
//  Feed_v1
//
//  Created by HungPB on 7/1/19.
//  Copyright © 2019 HungPB. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var poster : Poster?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Profile"
        self.didSetPoster()
        self.setupLayout()
    }
    
    let profileImage : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let nameTextView : MyTextView = {
        let tv = MyTextView()
        return tv
    }()
    
    let addressTextView : MyTextView = {
        let tv = MyTextView()
        return tv
    }()
    
    let birthdateTextView : MyTextView = {
        let tv = MyTextView()
        return tv
    }()
    
    func didSetPoster(){
        if let name = poster?.name {
            self.nameTextView.text = name
        }
        if let avatar = poster?.avatar {
            self.profileImage.image = UIImage(named: avatar)
        }
        if let address = poster?.address {
            self.addressTextView.text = address
        }
        if let birthdate = poster?.birthdate {
            self.birthdateTextView.text = birthdate
        }
    }
    
    func setupLayout(){
        view.addSubview(profileImage)

        profileImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalToConstant: 80),
            profileImage.widthAnchor.constraint(equalToConstant: 80),
            profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        
        let infoStackView = UIStackView(arrangedSubviews: [nameTextView,addressTextView,birthdateTextView])
        infoStackView.axis = .vertical
        infoStackView.distribution = .fillEqually
        infoStackView.spacing = 20
        
        view.addSubview(infoStackView)
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
            infoStackView.heightAnchor.constraint(equalToConstant: 160),
            infoStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 335/375),
            infoStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    
    
    
}

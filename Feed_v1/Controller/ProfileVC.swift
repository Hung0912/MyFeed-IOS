//
//  ProfileVC.swift
//  Feed_v1
//
//  Created by HungPB on 7/1/19.
//  Copyright © 2019 HungPB. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController{
    
    var poster : Poster? {
        didSet{
            guard let poster = self.poster else {return}
            print (poster)
            self.profileImage.image = UIImage(named: poster.avatar)
            self.nameTextField.text = poster.name
            self.addressTextField.text = poster.address
            self.birthdateTextField.text = poster.birthdate
            
            nameTextField.delegate = self
            addressTextField.delegate = self
            birthdateTextField.delegate = self

        }
    }
    override func viewDidLoad() {
        print("view did load")
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Profile"
        self.setupLayout()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        print("View will appear")
        print(nameTextField.frame)
        print(birthdateTextField.frame)
    }
    let profileImage : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let nameTextField : MyTextField = {
        let tf = MyTextField()
        return tf
    }()
    
    let addressTextField : MyTextField = {
        let tf = MyTextField()
        return tf
    }()
    
    let birthdateTextField : MyTextField = {
        let tf = MyTextField()
        return tf
    }()
    
    
    func setupLayout(){
        view.addSubview(profileImage)

        profileImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalToConstant: 80),
            profileImage.widthAnchor.constraint(equalToConstant: 80),
            profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        
        
        let infoStackView = UIStackView(arrangedSubviews: [nameTextField,addressTextField,birthdateTextField])
        
        infoStackView.axis = .vertical
//        infoStackView.distribution = .fillEqually
        infoStackView.spacing = 20
//        infoStackView.sizeToFit()
        
        
        view.addSubview(infoStackView)
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10),
//            infoStackView.heightAnchor.constraint(equalToConstant: 160),
            infoStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 335/375),
            infoStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
//            infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8)
            ])
    }
    
}

extension ProfileViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

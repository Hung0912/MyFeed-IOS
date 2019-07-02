//
//  NewPostVC.swift
//  Feed_v1
//
//  Created by HungPB on 7/1/19.
//  Copyright © 2019 HungPB. All rights reserved.
//

import UIKit

protocol NewPostVCDelegate : class{
    func handleAddPost(post : Post)
}

class NewPostVC: UIViewController{
    
    weak var delegate: NewPostVCDelegate?
    
    var imagePickerController = UIImagePickerController()
    let poster = Poster(name: "Hiroshi", address: "Tokyo", birthdate: "28-05-1989", avatar: "avatar")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "New Post"
        addBtn.addTarget(self, action: #selector(addPressed), for: .touchUpInside)
        addPhotoBtn.addTarget(self, action: #selector(addPhotoHandle), for: .touchUpInside)
        statusTextView.delegate = self
        imagePickerController.delegate = self
        self.setupLayout()
    }
    
    let statusTextView : UITextView = {
        let tv = UITextView()
        tv.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        tv.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        tv.layer.borderWidth = 1
//        tv.font = UIFont.systemFont(ofSize: 13)
        tv.font = UIFont(name: "Hiragino Sans", size: 13)
        tv.text = "write something..."
        tv.textColor = UIColor.lightGray
        return tv
    }()
    
    
    let addPhotoLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Add photo"
        lbl.font = UIFont(name: "Hiragino Sans", size: 14)
        return lbl
    }()
    
    let addPhotoBtn : UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.setImage(UIImage(named: "add_photo"), for: .normal)
        return btn
    }()
    
    var addBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        btn.setTitle("ADD", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        btn.titleLabel?.textAlignment = .center
        return btn
    }()
    
    func setupLayout(){
        view.addSubview(statusTextView)
        view.addSubview(addPhotoLabel)
        view.addSubview(addPhotoBtn)
        view.addSubview(addBtn)
        
        statusTextView.translatesAutoresizingMaskIntoConstraints = false
        addPhotoLabel.translatesAutoresizingMaskIntoConstraints = false
        addPhotoBtn.translatesAutoresizingMaskIntoConstraints = false
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            statusTextView.heightAnchor.constraint(equalToConstant: 150),
            statusTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            statusTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusTextView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            addPhotoLabel.heightAnchor.constraint(equalToConstant: 16),
            addPhotoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addPhotoLabel.widthAnchor.constraint(equalToConstant: 100),
            addPhotoLabel.topAnchor.constraint(equalTo: statusTextView.bottomAnchor, constant: 20),
            
            
            addPhotoBtn.heightAnchor.constraint(equalToConstant: 74),
            addPhotoBtn.widthAnchor.constraint(equalToConstant: 74),
            addPhotoBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            addPhotoBtn.topAnchor.constraint(equalTo: addPhotoLabel.topAnchor, constant: 20),
            
            addBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addBtn.heightAnchor.constraint(equalToConstant: 50),
            addBtn.widthAnchor.constraint(equalToConstant: 282),
            addBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
            ])
    }
    
    override func viewDidLayoutSubviews() {
        addBtn.layer.cornerRadius = addBtn.frame.height/2
        statusTextView.layer.cornerRadius = 5
    }
    
    @objc func addPhotoHandle(){
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func addPressed(){
        if let statusText = self.statusTextView.text {
            var post = Post(poster: poster, statusText: statusText, postImage: nil, createDate: Date())
            if self.addPhotoBtn.isSelected{
                post.postImage = addPhotoBtn.currentImage
            }
            if statusText != "" && statusText != "write something..."{
                print("Added")
                self.delegate?.handleAddPost(post: post)
            }else{
                let alert = UIAlertController(title: "Status is empty!", message: "Please write status before adding!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}

extension NewPostVC: UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "write something..."
            textView.textColor = UIColor.lightGray
        }
    }
}

extension NewPostVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagePicker = info[.originalImage] as? UIImage {
            addPhotoBtn.setImage(imagePicker, for: .selected)
            addPhotoBtn.isSelected = true
        }
        picker.dismiss(animated: true, completion: nil)
    }
}


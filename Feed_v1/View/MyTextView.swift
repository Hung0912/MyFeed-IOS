//
//  MyTextField.swift
//  Feed_v1
//
//  Created by HungPB on 7/1/19.
//  Copyright © 2019 HungPB. All rights reserved.
//

import UIKit

class MyTextField: UITextField {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.layer.borderWidth = 1
        self.font = UIFont.systemFont(ofSize: 16)
//        self.isEnabled = false

    }
    
    override func layoutSubviews() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.height / 2
//        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
//        self.leftViewMode = .always
    }
    

}

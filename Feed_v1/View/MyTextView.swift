//
//  MyTextView.swift
//  Feed_v1
//
//  Created by HungPB on 7/1/19.
//  Copyright © 2019 HungPB. All rights reserved.
//

import UIKit

class MyTextView: UITextView {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.layer.borderWidth = 1
        self.font = UIFont.systemFont(ofSize: 16)
        self.isEditable = false
        self.textContainerInset.left = 20
        self.textContainerInset.top = 10
        
    }
    
    override func layoutSubviews() {
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.height / 2
    }
    

}

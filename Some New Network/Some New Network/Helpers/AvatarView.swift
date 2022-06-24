//
//  avatarView.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 17.01.2022.
//

import UIKit

@IBDesignable class AvatarView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
            super.init(coder: coder)
            self.setupView()
        }
    
     func setupView() {
                
                self.layer.cornerRadius = self.bounds.height / 2
                self.layer.borderWidth = 2
                self.layer.borderColor = UIColor.purple.cgColor
        
                self.layer.shadowRadius = 10
                self.layer.shadowOffset = CGSize(width: 10, height: 10)
                self.layer.shadowOpacity = 0.7
                self.layer.shadowColor = UIColor.shadowColor.cgColor
    }
}

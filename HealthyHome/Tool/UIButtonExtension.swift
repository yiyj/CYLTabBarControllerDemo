//
//  UIButtonExtension.swift
//  HealthyHome
//
//  Created by apple on 2020/3/10.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

public extension UIButton {
    
    func setBackgroudImageWithTitle(imageName: String, title: String, color: UIColor, for state: UIControl.State) {
        self.setBackgroundImage(UIImage(named: imageName), for: state)
        self.setTitle(title, for: state)
        self.setTitleColor(color, for: state)
    }
    
    func setImageWithTitle(imageName: String, title: String, color: UIColor, for state: UIControl.State) {
        self.setImage(UIImage(named: imageName), for: state)
        self.setTitle(title, for: state)
        self.setTitleColor(color, for: state)
    }
    
    func setMaskBoundsWithTitle(title: String, color: UIColor, backColor: UIColor, radius: CGFloat) {
        self.backgroundColor = backColor
        self.setTitle(title, for: state)
        self.setTitleColor(color, for: state)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
}

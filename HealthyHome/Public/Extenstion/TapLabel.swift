//
//  TapLabel.swift
//  HealthyHome
//
//  Created by 康洲 on 2020/3/10.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

typealias tapblock = () -> Void

class TapLabel: UILabel {

    var tapBlock: tapblock!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tapAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        tapAction()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tapAction()
    }

    func tapAction() {
        
        self.isUserInteractionEnabled = true

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapActionBlock)))
    }
    
    @objc func tapActionBlock() {
        print("点击")
        if (self.tapBlock != nil) {
            self.tapBlock()
        }
    }
}

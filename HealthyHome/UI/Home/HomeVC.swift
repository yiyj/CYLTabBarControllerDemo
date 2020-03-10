//
//  HomeVC.swift
//  CYLTabBarController
//
//  Created by apple on 2020/2/14.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class HomeVC: ViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "首页"
        self.view.backgroundColor = .red

        addRightBarButtonItemImage("屏幕全屏", self, action: #selector(tapAction))
        
        let button = UIButton(frame: CGRect(origin: CGPoint(x: self.view.width/4, y: self.view.height/4), size: CGSize(width: self.view.width/2, height: self.view.height/2)))
        
    button.imageFromURL("https://fc3tn.baidu.com/it/u=3025909226,1763324618&fm=202&src=bqdata", placeholder: UIImage.imageWithColor(.purple), for: .normal)
        
    button.imageFromURL("https://dss0.baidu.com/73x1bjeh1BF3odCf/it/u=1062977167,2993416396&fm=85&s=06A1BA0FC6022FE5642185C90300F087", placeholder: UIImage.imageWithColor(.orange), shouldCacheImage: false, for: .selected)
        
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)

        self.view.addSubview(button)
    }
    
    
    @objc func buttonAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    
    @objc func tapAction() {
        let child = ChilderVC()
        self.navigationController?.pushViewController(child, animated: true)
    }
    
    
}

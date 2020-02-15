//
//  RootTabBarController.swift
//  CYLTabBarController
//
//  Created by apple on 2020/2/14.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class RootTabBarController: CYLTabBarController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard self.hideTabbarLine else {// 隐藏 tabbar 上部的线
            return
        }
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        customizeInterface()
    }
    
    /// MARK:TabBard底部标签设置
    func customizeInterface() {
        
        if #available(iOS 11.0, *) {
            tabBar.unselectedItemTintColor = .lightGray
            tabBar.tintColor = .hexColor("3A57ED")
        }else {
            let normalAttrs: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.red]
            let selectAttrs: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.blue]

            self.tabBarItem.setTitleTextAttributes(normalAttrs as? [NSAttributedString.Key: AnyObject], for: .normal)
            self.tabBarItem.setTitleTextAttributes(selectAttrs as? [NSAttributedString.Key: AnyObject], for: .selected)
        }
        
        //MARK:设置背景图片
        tabBar.backgroundImage = UIImage.imageWithColor(.white)
        //MARK:去除 TabBar 自带的顶部阴影
        self.tabBar.shadowImage = UIImage()
        
        //可去除TabBar顶部横线会锁死线程bug
//        appearanceShawIamge()
        
        //添加阴影
//        tabBar.layer.shadowColor = UIColor.hexColor("3A57ED").cgColor
//        tabBar.layer.shadowOffset = CGSize(width: 0, height: -3)
//        tabBar.layer.shadowOpacity = 1
    }
    
    @available(iOS 13, *)
    func appearanceShawIamge() {
        let appearance = tabBar.standardAppearance
        appearance.shadowImage = .imageWithColor(.clear)
        tabBar.standardAppearance = appearance
    }
    
    lazy var hideTabbarLine: Bool = {
        // 隐藏 tabbar 上部的线
        for view in self.tabBar.subviews {
            for image in view.subviews {
                if image.height < 2 {
                    image.isHidden = true
                    return true
                }
            }
        }
        return true
    }()
}

extension RootTabBarController {
    
    override func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        updateSelectionStatusIfNeeded(for: tabBarController, shouldSelect: viewController)
        
        return true
    }
}

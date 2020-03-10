//
//  TabBarCommon.swift
//  HealthyHome
//
//  Created by apple on 2020/2/14.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class TabBarCommon: NSObject {
    
    /// MARK: 切换跳转主界面
    class func tabBarSelectIndex(_ selectIndex: Int) {
        CYLPlusButtonSubclass.register()
        let tabBarController = RootTabBarController(viewControllers: ViewControllers(), tabBarItemsAttributes: tabBarItemsAttributesForController())
        tabBarController.selectedIndex = selectIndex;
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = tabBarController
    }
    
    /// MARK: 切换跳转主界面 操作其他事件
    class func completionhandler(_ selectIndex: Int, _: () ->())  {
        tabBarSelectIndex(selectIndex)
    }
    
    /// MARK: 进入APP
    class func enterApp(_ : () -> ()) {
        TabBarController()
    }
    
    /// MARK: 创建根视图
    class func TabBarController() {
        CYLPlusButtonSubclass.register()
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = RootTabBarController(viewControllers: ViewControllers(), tabBarItemsAttributes: tabBarItemsAttributesForController())
    }
    
    //MARK:主界面
    class func ViewControllers() -> [RootNavigationController] {

        let home = RootNavigationController(rootViewController: HomeVC())
        let healthy = RootNavigationController(rootViewController: HealthyVC())
        let friends = RootNavigationController(rootViewController: FriendsVC())
        let me = RootNavigationController(rootViewController: MeVC())
        
        let viewControllers = [home, healthy, friends, me]

        return viewControllers
    }
        
    
    class func tabBarItemsAttributesForController() -> [[String: String]] {
            
        let tabBarItemHome = [CYLTabBarItemTitle: "首页",
                              CYLTabBarItemImage: "Home",
                              CYLTabBarItemSelectedImage: "HomeSelected"]
        
        let tabBarItemHealthy = [CYLTabBarItemTitle: "健康",
                              CYLTabBarItemImage: "Message",
                              CYLTabBarItemSelectedImage: "MessageSelected"]

        let tabBarItemFriends = [CYLTabBarItemTitle: "朋友圈",
                              CYLTabBarItemImage: "lianxiren",
                              CYLTabBarItemSelectedImage: "lianxirenSelected"]
        
        let tabBarItemMe = [CYLTabBarItemTitle: "我的",
                              CYLTabBarItemImage: "Me",
                              CYLTabBarItemSelectedImage: "MeSelected"]

        let tabBarItemsAttributes = [tabBarItemHome, tabBarItemHealthy, tabBarItemFriends, tabBarItemMe]
        
        return tabBarItemsAttributes
    }

    
    //MARK: 获取当前页面控制器
    class func currentvc() -> UIViewController {
        let keyWindow = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController
        let rootVC = keyWindow!
//        return getVisibleViewControllerFrom(vc: rootVC)
        return topViewControllerWithRootViewController(rootVC: rootVC)
    }
    
    //方法1
    class func getVisibleViewControllerFrom(vc: UIViewController) -> UIViewController {
        
        if vc.isKind(of: UINavigationController.self) {
            return getVisibleViewControllerFrom(vc: (vc as! UINavigationController).visibleViewController!)
        }else if vc.isKind(of: UITabBarController.self) {
            return getVisibleViewControllerFrom(vc: (vc as! UITabBarController).selectedViewController!)
        }else {
            if (vc.presentedViewController != nil) {
                return getVisibleViewControllerFrom(vc: vc.presentedViewController!)
            }else {
                return vc
            }
        }
    }
    
    //方法2
    class func topViewControllerWithRootViewController(rootVC: UIViewController) -> UIViewController {
        
        if rootVC.isKind(of: UITabBarController.self) {
            let tabVC = rootVC as! UITabBarController
            return topViewControllerWithRootViewController(rootVC: tabVC.selectedViewController!)
        } else if rootVC.isKind(of: UINavigationController.self) {
            let navc = rootVC as! UINavigationController
            return topViewControllerWithRootViewController(rootVC: navc.visibleViewController!)
        } else if (rootVC.presentedViewController != nil) {
            return topViewControllerWithRootViewController(rootVC: rootVC.presentedViewController!)
        } else {
            return rootVC
        }
        
    }
    
    //MARK: 验证
    class func kindVc(vc: UIViewController.Type) -> Bool {
        return currentvc().isKind(of: vc)
    }
    
}

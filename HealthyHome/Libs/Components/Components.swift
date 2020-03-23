//
//  Components.swift
//  HealthyHome
//
//  Created by 康洲 on 2020/3/23.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

/// 屏幕宽度
var KScreenHeight = UIScreen.main.bounds.height
/// 屏幕高度
var KScreenWidth = UIScreen.main.bounds.width
/// 屏幕比例
var kScale = UIScreen.main.scale
/// 导航栏高度+状态栏(iphonex 88)
var KNavgationBarHeight: CGFloat = isX() == true ? 88:64
/// tabbar高度(iphonex 83)
var KTabBarHeight: CGFloat = isX() == true ? 83:49
/// iphonex 底部间距
var IphoneXBottomSpace: CGFloat = isX() == true ? 34:0

var dialogWidth: CGFloat = 300

var RGBAColor: (CGFloat, CGFloat, CGFloat, CGFloat) -> UIColor = {red, green, blue, alpha in
    return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha);
}

/// 设置主题色，2个按钮时只设置右边的主题色，1个按钮时显示主题色
public var mainColor: UIColor = UIColor.init(red: 13/255.0, green: 133/255.0, blue: 255/255.0, alpha: 1)

let alterWindow: UIWindow = kWindow()
func kWindow() -> UIWindow {
    let window: UIWindow!
    if #available(iOS 13, *) {
        window = UIApplication.shared.connectedScenes
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows.first
    }else {
        window = UIApplication.shared.keyWindow
    }
    return window
}

/// X系列 在竖屏下，keyWindow 的 safeAreaInsets 值为：{top: 44, left: 0, bottom: 34, right: 0}
/// 而在横屏下，其值为：{top: 0, left: 44, bottom: 21, right: 44}
func isX() -> Bool {
    let window = kWindow()
    
    if #available(iOS 11.0, *) {
        let bottomSafeInset = window.safeAreaInsets.bottom
        if (bottomSafeInset == 34.0 || bottomSafeInset == 21.0) {
            return true
        } else {
            if (UIScreen.main.bounds.height > 800) {
               return true
            } else {
                return false
            }
        }
    } else {
        if (UIScreen.main.bounds.height > 800) {
            return true
        } else {
            return false
        }
    }
}

//通知
let HDNotificationCenter = NotificationCenter.default
//存储
let HDUserDefaults = UserDefaults.standard




//
//  ScreenTools.swift
//  HealthyHome
//
//  Created by 康洲 on 2020/3/23.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

typealias ScreenToolsClouse = (UIDeviceOrientation)->()

class ScreenTools: NSObject {
    static let share = ScreenTools()
        
        var screenClouse: ScreenToolsClouse?
        
        override init() {
            super.init()
            
            NotificationCenter.default.addObserver(self, selector: #selector(receiverNotification), name: UIDevice.orientationDidChangeNotification, object: nil)
        }
        
        @objc func receiverNotification(){
            let orient = UIDevice.current.orientation
            
            switch orient {
            case .portrait :
                print("屏幕正常竖向")
                KScreenWidth = UIScreen.main.bounds.width
                KScreenHeight = UIScreen.main.bounds.height
                if self.screenClouse != nil {
                    self.screenClouse!(.portrait)
                }
                break
            case .portraitUpsideDown:
                print("屏幕倒立")
                KScreenWidth = UIScreen.main.bounds.width
                KScreenHeight = UIScreen.main.bounds.height
                if self.screenClouse != nil {
                    self.screenClouse!(.portraitUpsideDown)
                }
                break
            case .landscapeLeft:
                print("屏幕左旋转")
                KScreenWidth = UIScreen.main.bounds.width
                KScreenHeight = UIScreen.main.bounds.height
                if self.screenClouse != nil {
                    self.screenClouse!(.landscapeLeft)
                }
                break
            case .landscapeRight:
                print("屏幕右旋转")
                KScreenWidth = UIScreen.main.bounds.width
                KScreenHeight = UIScreen.main.bounds.height
                if self.screenClouse != nil {
                    self.screenClouse!(.landscapeRight)
                }
                break
            default:
                break
            }
        }
}

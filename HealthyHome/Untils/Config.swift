//
//  Config.swift
//  HealthyHome
//
//  Created by apple on 2020/3/23.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class Config: NSObject {

    public static let share = Config()
       
    // loading展示时间最长为60秒
    public var maxShowInterval: Float = 60
   
    /// switch主题色、progressView主题色、
    public var mainColor: UIColor = UIColor.init(red: 13/255.0, green: 133/255.0, blue: 255/255.0, alpha: 1)
   
    public func id_setupMainColor(color: UIColor) {
        self.mainColor = color
    }
}

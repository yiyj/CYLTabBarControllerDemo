//
//  ComponentAlter.swift
//  HealthyHome
//
//  Created by apple on 2020/3/23.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

public class ComponentAlter: NSObject {

    /// 普通弹框
    public static func show(
                               title: String? = nil,
                               msg: String? = nil,
                               countDownNumber: Int? = nil,
                               leftActionTitle: String?,
                               rightActionTitle: String?,
                               leftHandler: (()->())? = nil,
                               rightHandler:(()->())? = nil) {
        _ = AlterUtil.init(title: title, msg: msg, leftActionTitle: leftActionTitle, rightActionTitle: rightActionTitle, leftHandler: leftHandler, rightHandler: rightHandler,countDownNumber: countDownNumber,type: UtilType.normal)
    }
    public static func id_showImg(
                               success: UtilImageType? = nil,
                               msg: String? = nil,
                               leftActionTitle: String?,
                               rightActionTitle: String?,
                               leftHandler: (()->())? = nil,
                               rightHandler:(()->())? = nil) {
        _ = AlterUtil.init(msg: msg, leftActionTitle: leftActionTitle, rightActionTitle: rightActionTitle, leftHandler: leftHandler, rightHandler: rightHandler,success: success,type: UtilType.image)
    }
    
    ///输入框
    public static func showInput(
                                  msg: String? = nil,
                                  leftActionTitle: String?,
                                  rightActionTitle: String?,
                                  leftHandler: ((String)->())? = nil,
                                  rightHandler:((String)->())? = nil) {
        _ = AlterUtil.init(msg: msg, leftActionTitle: leftActionTitle, rightActionTitle: rightActionTitle, leftHandler: leftHandler, rightHandler: rightHandler, type: UtilType.input)
    }
    
    /// 自定义内容
    public static func id_showCustom(
        msg: String? = nil,
        leftActionTitle: String?,
        rightActionTitle: String?,
        customView: UIView?,
        leftHandler: ((UIView?)->())? = nil,
        rightHandler:((UIView?)->())? = nil) {
        _ = AlterUtil.init(msg: msg, leftActionTitle: leftActionTitle, rightActionTitle: rightActionTitle,customView: customView, leftHandler: leftHandler, rightHandler: rightHandler, type: UtilType.custom)
    }
}

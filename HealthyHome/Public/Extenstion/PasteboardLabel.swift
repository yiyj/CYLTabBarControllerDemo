//
//  PasteboardLabel.swift
//  HealthyHome
//
//  Created by Apple on 2020/3/6.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit


class PasteboardLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        longPressAction()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        longPressAction()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        longPressAction()
    }
    
    //MARK：必须实现的两个方法
    //重写返回
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.copy(_:)) {
            return true
        }else if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return true
        }else if action == #selector(UIResponderStandardEditActions.cut(_:)) {
            return true
        }
        return false
    }
    
    private func longPressAction() {
        
        self.isUserInteractionEnabled = true
        
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(showMenuController)))
    }
    
    @objc func showMenuController(_ sender: UIGestureRecognizer) {
        guard sender.state == .began else {
            return
        }
        
        //第一响应者
        self.becomeFirstResponder()
        //菜单j控制器
        let menuController = UIMenuController.shared
                
        if !menuController.isMenuVisible {
            //设置菜单控制器点击区域为当前控件bounds
//            menuController.setTargetRect(self.bounds, in: self)
            //菜单显示器可见
//            menuController.setMenuVisible(true, animated: true)
            menuController.showMenu(from: self, rect: self.bounds)
        }
        
    }
    
    //MARK: 复制
    override func copy(_ sender: Any?) {
        UIPasteboard.general.string = self.text
    }
    
    //MARK:粘贴
    override func paste(_ sender: Any?) {
        self.text = UIPasteboard.general.string
    }
    
    //MARK:剪切
    override func cut(_ sender: Any?) {
        UIPasteboard.general.string = self.text
        self.text = ""
    }
    
    
}




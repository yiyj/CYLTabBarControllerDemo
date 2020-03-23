//
//  AlterUtil.swift
//  HealthyHome
//
//  Created by 康洲 on 2020/3/23.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

public enum UtilType {
    case normal //类似系统的弹框
    case image  //带有图片的弹框
    case input  //可输入文字的弹框
    case custom //自定义内容
}

public enum UtilImageType {
    case success  //成功
    case fail     //失败
    case warning  //警告
}

class AlterUtil: Operation {

    lazy var coverView: UIView = {
        let cover = UIView(frame: CGRect(x: 0, y: 0, width: KScreenWidth, height: KScreenHeight))
        cover.alpha = 0.1
        cover.backgroundColor = .black
        return cover
    }()
    
    private var _executing = false
    override var isExecuting: Bool {
        get {
            return self._executing
        }
        set {
            self.willChangeValue(forKey: "isExecuting")
            self.isExecuting = newValue
            self.didChangeValue(forKey: "isExecuting")
        }
    }
    
    private var _finished = false
    override var isFinished: Bool {
        get {
            return self._finished
        }
        set {
            self.willChangeValue(forKey: "isFinished")
            self.isFinished = newValue
            self.didChangeValue(forKey: "isFinished")
        }
    }
    
    var normalView: AlterNormalView? = AlterNormalView()
    var imgView: AlterImageView? = AlterImageView()
    var inputView: AlterInputView? = AlterInputView()
    var customView: AlterCustomView? = AlterCustomView()

    var superComponent: UIView = alterWindow
    var type = UtilType.normal
    var imageType: UtilImageType? = nil

    
    init(
        title: String? = nil,
        msg: String? = nil,
        leftActionTitle: String?,
        rightActionTitle: String?,
        leftHandler: (()->())? = nil,
        rightHandler:(()->())? = nil,
        countDownNumber: Int? = nil,
        success: UtilImageType? = nil,
        type: UtilType? = nil) {
        
        super.init()
        
        self.imageType = success
        self.type = type ?? UtilType.normal
        
        if self.type == .normal {
            self.setupNormalView(title: title,msg: msg,leftActionTitle: leftActionTitle,rightActionTitle: rightActionTitle,leftHandler: leftHandler,rightHandler:rightHandler, countDownNumber: countDownNumber)
        }
        if self.type == .image {
            self.setupImageView(msg: msg,leftActionTitle: leftActionTitle,rightActionTitle: rightActionTitle,leftHandler: leftHandler,rightHandler:rightHandler)
        }

        self.commonUI()
    }
    /// 输入框类型
    init(
        msg: String? = nil,
        leftActionTitle: String?,
        rightActionTitle: String?,
        leftHandler: ((String)->())? = nil,
        rightHandler:((String)->())? = nil,
        type: UtilType? = nil) {
        
        super.init()
        
        self.type = type ?? UtilType.input

        self.setupInputView(msg: msg,leftActionTitle: leftActionTitle,rightActionTitle: rightActionTitle,leftHandler: leftHandler,rightHandler:rightHandler)
        
        self.commonUI()
    }
    
    /// 自定义类型
    init(
        msg: String? = nil,
        leftActionTitle: String?,
        rightActionTitle: String?,
        customView: UIView?,
        leftHandler: ((UIView?)->())? = nil,
        rightHandler:((UIView?)->())? = nil,
        type: UtilType? = nil) {
        
        super.init()
        
        self.type = type ?? UtilType.custom
        
        self.setupCustomView(msg: msg,leftActionTitle: leftActionTitle,rightActionTitle: rightActionTitle, customView: customView,leftHandler: leftHandler,rightHandler:rightHandler)
        
        self.commonUI()
    }
    
    func commonUI() {
        
        // 单利队列中每次都加入一个新建的Operation
        AlterlManager.share.add(self)
        
        // 临时处理一下，如果没隔0.1秒就调用show,界面上会显示所有的dialog的叠加，dialog的阴影也会逐渐变黑，所以如果再很短的时间内，连续调用show，就只展示一个cover
        if AlterlManager.share.queue.operationCount < 2 {
            self.superComponent.addSubview(self.coverView)
        }
        
        if self.coverView.superview != nil {
            self.coverView.translatesAutoresizingMaskIntoConstraints = false
            self.superComponent.addConstraints([
                NSLayoutConstraint.init(item: self.coverView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superComponent, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint.init(item: self.coverView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superComponent, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0),
                NSLayoutConstraint.init(item: self.coverView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superComponent, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0),
                NSLayoutConstraint.init(item: self.coverView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.superComponent, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0),
                ])
        }
    }
    
    func setupNormalView(title: String? = nil,
                         msg: String? = nil,
                         leftActionTitle: String?,
                         rightActionTitle: String?,
                         leftHandler: (()->())? = nil,
                         rightHandler:(()->())? = nil,
                         countDownNumber: Int? = nil) {
        self.normalView = AlterNormalView()
        self.normalView?.title = title
        self.normalView?.msg = msg
        self.normalView?.leftActionTitle = leftActionTitle
        self.normalView?.rightActionTitle = rightActionTitle
        self.normalView?.countDownNumber = countDownNumber ?? 0
        self.normalView?.leftHandler = {() in
            self.dismiss()
            if leftHandler != nil {
                leftHandler!()
            }
        }
        self.normalView?.rightHandler = {() in
            self.dismiss()
            if rightHandler != nil {
                rightHandler!()
            }
        }
    }
    
    func setupImageView(msg: String? = nil,
                        leftActionTitle: String?,
                        rightActionTitle: String?,
                        leftHandler: (()->())? = nil,
                        rightHandler:(()->())? = nil) {
        self.imgView = AlterImageView()
        self.imgView?.msg = msg
        self.imgView?.leftActionTitle = leftActionTitle
        self.imgView?.rightActionTitle = rightActionTitle
        self.imgView?.leftHandler = {() in
            self.dismiss()
            if leftHandler != nil {
                leftHandler!()
            }
        }
        self.imgView?.rightHandler = {() in
            self.dismiss()
            if rightHandler != nil {
                rightHandler!()
            }
        }
    }
    func setupInputView(msg: String? = nil,
                        leftActionTitle: String?,
                        rightActionTitle: String?,
                        leftHandler: ((String)->())? = nil,
                        rightHandler:((String)->())? = nil) {
        self.inputView = AlterInputView()
        self.inputView?.msg = msg
        self.inputView?.leftActionTitle = leftActionTitle
        self.inputView?.rightActionTitle = rightActionTitle
        self.inputView?.leftHandler = {(text) in
            self.dismiss()
            if leftHandler != nil {
                leftHandler!(text)
            }
        }
        self.inputView?.rightHandler = {(text) in
            self.dismiss()
            if rightHandler != nil {
                rightHandler!(text)
            }
        }
    }
    
    func setupCustomView(msg: String? = nil,
                         leftActionTitle: String?,
                         rightActionTitle: String?,
                         customView: UIView?,
                         leftHandler: ((UIView?)->())? = nil,
                         rightHandler:((UIView?)->())? = nil) {
        self.customView = AlterCustomView()
        self.customView?.msg = msg
        self.customView?.customView = customView
        self.customView?.leftActionTitle = leftActionTitle
        self.customView?.rightActionTitle = rightActionTitle
        self.customView?.leftHandler = {(view) in
            self.dismiss()
            if leftHandler != nil {
                leftHandler!(view)
            }
        }
        self.customView?.rightHandler = {(view) in
            self.dismiss()
            if rightHandler != nil {
                rightHandler!(view)
            }
        }
    }

    open override func cancel() {
        super.cancel()
        self.dismiss()
    }
    override func start() {
        let isRunnable = !self.isFinished && !self.isCancelled && !self.isExecuting
        guard isRunnable else { return }
        guard Thread.isMainThread else {
            DispatchQueue.main.async { [weak self] in
                self?.start()
            }
            return
        }
        main()
    }
    override func main() {
        self.isExecuting = true
        
        DispatchQueue.main.async {
            
            if self.type == .normal {
                self.showNormalView()
            }
            if self.type == .image {
                self.showImageView()
            }
            if self.type == .input {
                self.showInputView()
            }
            if self.type == .custom {
                self.showCustomView()
            }
        }
    }
    
    func showNormalView() {
        self.superComponent.addSubview(self.normalView ?? AlterNormalView())
        self.normalView?.msgLabel.textAlignment = AlterlManager.share.textAlignment
        self.normalView?.setNeedsLayout()
        
        if AlterlManager.share.supportAnimate {
            self.normalView?.layer.add(AlterlManager.share.animate, forKey: nil)
        }
    }
    func showImageView() {
        self.superComponent.addSubview(self.imgView ?? AlterImageView())
        self.imgView?.msgLabel.textAlignment = AlterlManager.share.textAlignment
        
        if self.imageType == .success {
            self.imgView?.iconView.image = AlterlManager.share.successImage
        } else if self.imageType == .fail {
            self.imgView?.iconView.image = AlterlManager.share.failImage
        } else if self.imageType == .warning {
            self.imgView?.iconView.image = AlterlManager.share.warnImage
        } else {
            self.imgView?.iconView.image = nil
        }
        self.normalView?.setNeedsLayout()

        if AlterlManager.share.supportAnimate {
            self.imgView?.layer.add(AlterlManager.share.animate, forKey: nil)
        }
    }
    func showInputView() {
        self.superComponent.addSubview(self.inputView ?? AlterInputView())
        self.inputView?.msgLabel.textAlignment = AlterlManager.share.textAlignment
        self.inputView?.setNeedsLayout()
        
        if AlterlManager.share.supportAnimate {
            self.inputView?.layer.add(AlterlManager.share.animate, forKey: nil)
        }
    }
    func showCustomView() {
        self.superComponent.addSubview(self.customView ?? AlterCustomView())
        self.customView?.msgLabel.textAlignment = AlterlManager.share.textAlignment
        self.customView?.setNeedsLayout()
        
        if AlterlManager.share.supportAnimate {
            self.customView?.layer.add(AlterlManager.share.animate, forKey: nil)
        }
    }
}

extension AlterUtil {
    
    func dismiss() {
        
        UIView.animate(withDuration: 0.1, animations: {
            self.normalView?.alpha = 0.1
            self.imgView?.alpha = 0.1
            self.inputView?.alpha = 0.1
            self.customView?.alpha = 0.1
        }) { (finsh) in
            self.coverView.removeFromSuperview()
            self.normalView?.removeFromSuperview()
            self.imgView?.removeFromSuperview()
            self.inputView?.removeFromSuperview()
            self.customView?.removeFromSuperview()
            self.normalView = nil
            self.imgView = nil
            self.inputView = nil
            self.customView = nil

            self.finish()
        }
    }
    
    func finish() {
        self.isExecuting = false
        self.isFinished = true
        //取消所有线程
        if AlterlManager.share.supportQuene == false {
            AlterlManager.share.cancelAll()
        }
    }
}

//
//  HUDView.swift
//  HealthyHome
//
//  Created by 康洲 on 2020/3/11.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit



extension UIView {
    //MARK: 菊花显示 dispalyDuration默认停留时间秒
    public func showHud(dispalyDuration: CGFloat = 30.0) {
        hiddeHud()
        
        let frame = CGRect(x: 0, y: 0, width: 78, height: 78)
        let backView = UIView(frame: self.bounds)
        backView.tag = 11111
        self.addSubview(backView)
        
        let hudView = UIView(frame: frame)
        hudView.center = CGPoint(x: backView.frame.width/2, y: backView.frame.height/2)
        hudView.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.8)
        hudView.layer.masksToBounds = true
        hudView.layer.cornerRadius = 12
        backView.addSubview(hudView)
        
        let indicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicatorView.frame = CGRect(x: 21, y: 21, width: 36, height: 36)
        indicatorView.startAnimating()
        hudView.addSubview(indicatorView)
               
        hudView.alpha = 0.0
        UIView.animate(withDuration: 0.2, animations: {
            hudView.alpha = 1
        })
        
        self.perform(#selector(hiddeHud), with: nil, afterDelay: TimeInterval(dispalyDuration))

    }
    
    
    func showEmptyView(_ imageName: String, text: String, hander: () -> ()) {
        
    }
    
    @objc func hiddeHud() {
        let backView = self.viewWithTag(11111)
        guard let bView = backView else { return }
        bView.removeFromSuperview()
    }
}

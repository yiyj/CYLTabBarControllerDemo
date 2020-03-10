//
//  ImageViewExtension.swift
//
//  ImageHelper
//
//  Created by yyj on 2020/03/1.
//  Copyright (c) 2020 apple. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

public extension UIImageView {
    
    /**
     通过URL下载请求返回UIImage
     
     - Parameter url: 图片地址
     - Parameter placeholder: 默认image.
     - Parameter fadeIn: 显示效果.
     - Parameter closure: 闭包返回image
     
     - Returns A new image
     */
    func imageFromURL(_ url: String, placeholder: UIImage, fadeIn: Bool = true, shouldCacheImage: Bool = true, closure: ((_ image: UIImage?) -> ())? = nil)
    {
        self.image = UIImage.image(fromURL: url, placeholder: placeholder, shouldCacheImage: shouldCacheImage) {
            (image: UIImage?) in
            if image == nil {
                return
            }
            self.image = image
            if fadeIn {
                let transition = CATransition()
                transition.duration = 0.5
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition.type = CATransitionType.fade
                self.layer.add(transition, forKey: nil)
            }
            closure?(image)
        }
    }
    
    
}
 
public extension UIButton {
    /**
    通过URL请求加载
    
    - Parameter url: 图片地址
    - Parameter placeholder: 默认image.
    - Parameter shouldCacheImage: 是否缓存数据 默认是.
    - Parameter state: 状态
    
    */
    func imageFromURL(_ url: String, placeholderImage: UIImage, shouldCacheImage: Bool = true, for state: UIControl.State)
    {
        if url.isEmpty || url.count == 0 {
            self.setImage(placeholderImage, for: state)
        }else {
            if shouldCacheImage {
                if let image = UIImage.shared.object(forKey: url as AnyObject) as? UIImage {
                    DispatchQueue.main.sync {
                        self.setImage(image, for: state)
                    }
                }
            }
            // Fetch Image
            let session = URLSession(configuration: URLSessionConfiguration.default)
            if let nsURL = URL(string: url) {
                session.dataTask(with: nsURL, completionHandler: { (data, response, error) -> Void in
                    if (error != nil) {
                        DispatchQueue.main.sync {
                            self.setImage(placeholderImage, for: state)
                        }
                    }
                    if let data = data, let image = UIImage(data: data) {
                        if shouldCacheImage {
                            UIImage.shared.setObject(image, forKey: url as AnyObject)
                        }
                        DispatchQueue.main.sync {
                            self.setImage(image, for: state)
                        }
                    }
                    session.finishTasksAndInvalidate()
                }).resume()
            }
        }
    }
    
}
 

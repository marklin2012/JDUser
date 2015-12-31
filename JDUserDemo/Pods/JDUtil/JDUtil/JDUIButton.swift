//
//  JDUIButton.swift
//  JDUtilDemo
//
//  Created by O2.LinYi on 15/12/24.
//  Copyright © 2015年 jd.com. All rights reserved.
//

import UIKit

public extension UIButton {
    public func centerVerticallyWithPadding(padding: CGFloat) {
        if imageView == nil || titleLabel == nil {
            return
        }
        
        let imageSize = imageView!.frame.size
        let titleSize = titleLabel!.frame.size
        
        let totalHeight = (imageSize.height + titleSize.height + padding)
        self.imageEdgeInsets = UIEdgeInsetsMake(-(totalHeight - imageSize.height), 0.0, 0.0, -titleSize.width)
        self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(totalHeight - titleSize.height), 0.0)
    }
    
    public func centerVertically() {
        self.centerVerticallyWithPadding(6.0)
    }
    
    public func centerVerticallyWithoutTitleLabel() {
        titleLabel?.frame.size = CGSizeZero
        titleLabel?.removeFromSuperview()
        
        let imageSize = imageView!.frame.size
        
        let width : CGFloat = (self.frame.width - imageSize.width) / 2
        let height : CGFloat = (self.frame.height - imageSize.height) / 2
        
        self.imageEdgeInsets = UIEdgeInsetsMake(height,
            width, height, width)
    }
    
}

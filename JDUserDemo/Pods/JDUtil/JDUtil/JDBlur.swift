//
//  JDBlur.swift
//  JDUtilDemo
//
//  Created by O2.LinYi on 15/12/24.
//  Copyright © 2015年 jd.com. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    public func createBlur(effectStyle: UIBlurEffectStyle = .Light) {
        createBlur(backgroundColor: UIColor.clearColor(), effectStyle: effectStyle)
    }
    
    public func createBlur(backgroundColor backgroundColor: UIColor?, effectStyle: UIBlurEffectStyle = .Light) {
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            
            self.backgroundColor = backgroundColor
            
            let blurView = UIVisualEffectView(effect: UIBlurEffect(style: effectStyle))
            blurView.autoresizingMask = UIViewAutoresizing.FlexibleHeight
            blurView.frame = self.bounds
            
            self.insertSubview(blurView, atIndex: 0)
        }
    }
    
    public func createBlur(backgroundColorAlpha alpha: CGFloat, effectStyle: UIBlurEffectStyle = .Light) {
        let backgroundColor = self.backgroundColor?.colorWithAlphaComponent(alpha)
        createBlur(backgroundColor: backgroundColor, effectStyle: effectStyle)
    }
}

public extension UITableView {
    override public func createBlur(effectStyle: UIBlurEffectStyle = .Light) {
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            
            self.backgroundColor = UIColor.clearColor()
            
            let blurEffect = UIBlurEffect(style: effectStyle)
            self.backgroundView = UIVisualEffectView(effect: blurEffect)
            self.separatorEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
        }
    }
}
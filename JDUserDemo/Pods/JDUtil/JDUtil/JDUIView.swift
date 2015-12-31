//
//  JDUIView.swift
//  JDUtilDemo
//
//  Created by O2.LinYi on 15/12/24.
//  Copyright © 2015年 jd.com. All rights reserved.
//

import UIKit


// MARK: -  View Tree
public extension UIView {
    
    public func topView () -> UIView? {
        var topView = superview
        
        while topView != nil && topView?.superview != nil {
            topView = topView!.superview
        }
        
        return topView
    }
    
    public func removeSubviews () {
        removeSubViews(self.subviews)
    }
    
    public func removeSubViews (views: [UIView]) {
        for view in views {
            view.removeFromSuperview()
        }
    }
}


// MARK: -  Borders

public extension UIView {
    public func addTopBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        border.frame = CGRectMake(0, 0, self.frame.size.width, width)
        self.layer.addSublayer(border)
    }
    
    public func addRightBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        border.frame = CGRectMake(self.frame.size.width - width, 0, width, self.frame.size.height)
        self.layer.addSublayer(border)
    }
    
    public func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        border.frame = CGRectMake(0, self.frame.size.height - width, self.frame.size.width, width)
        self.layer.addSublayer(border)
    }
    
    public func addLeftBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.CGColor
        border.frame = CGRectMake(0, 0, width, self.frame.size.height)
        self.layer.addSublayer(border)
    }
}


// MARK: - Layers

public extension UIView {
    
    public func getIndicator () -> UIActivityIndicatorView {
        var indicator: UIActivityIndicatorView!
        
        for subview in self.subviews {
            indicator = subview as? UIActivityIndicatorView
            if indicator != nil {
                break
            }
        }
        
        if indicator == nil {
            indicator = UIActivityIndicatorView(activityIndicatorStyle: .White)
            indicator.frame = self.frame
            indicator.center = self.center
            self.addSubview(indicator)
        }
        
        return indicator
    }
    
    public func getBlackDrop () -> CALayer {
        let BlackLayerName = "blackLayer"
        
        var blackLayer: CALayer!
        
        if self.layer.sublayers != nil {
            for layer in self.layer.sublayers! {
                if layer.name == BlackLayerName {
                    blackLayer = layer
                    break
                }
            }
        }
        
        if blackLayer == nil {
            blackLayer = CALayer()
            blackLayer.bounds = self.bounds
            blackLayer.frame.origin = CGPointZero
            blackLayer.backgroundColor = UIColor.blackColor().CGColor
            blackLayer.name = BlackLayerName
            self.layer.addSublayer(blackLayer)
        }
        
        return blackLayer
    }
}


// MARK: - Effects

public extension UIView {
    public func flashScreen(duration: NSTimeInterval = 0.5) {
        
        let aView = UIView(frame: self.frame)
        aView.backgroundColor = UIColor.whiteColor()
        self.addSubview(aView)
        
        UIView.animateWithDuration(
            duration,
            delay: 0,
            options: UIViewAnimationOptions.CurveEaseInOut,
            animations: {
                aView.alpha = 0.0
            },
            completion: { done in
                aView.removeFromSuperview()
        })
    }
}


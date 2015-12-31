//
//  JDColor.swift
//  JDUtilDemo
//
//  Created by O2.LinYi on 15/12/24.
//  Copyright © 2015年 jd.com. All rights reserved.
//

import UIKit

public extension UIColor {
    
    /**
     使用 0 ~ 255 的颜色值，Example: UIColor(intRed: 51.5, green: 51, blue: 51, alpha: 1)
     */
    public convenience init(intRed r: Double, green g: Double, blue b: Double, alpha a: Double) {
        self.init(red: CGFloat(r/Double(255)), green: CGFloat(g/Double(255)), blue: CGFloat(b/Double(255)), alpha: CGFloat(a))
    }
}
//
//  JDString.swift
//  JDUtilDemo
//
//  Created by O2.LinYi on 15/12/24.
//  Copyright © 2015年 jd.com. All rights reserved.
//  自定义下标

import Foundation


public extension String {
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    // 使用方法：
    // print("myTest"[3]) //the result is "e"
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    // 使用方法：
    // print("myTest"[1...3]) //the result is "yTe"
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: startIndex.advancedBy(r.startIndex), end: startIndex.advancedBy(r.endIndex)))
    }
}
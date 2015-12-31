//
//  JDArray.swift
//  JDUtilDemo
//
//  Created by O2.LinYi on 15/12/24.
//  Copyright © 2015年 O2.LinYi. All rights reserved.
//

import Foundation

public extension Array where Element: Equatable {
    
    /**
     添加或删除某个元素（如果存在则删除，如果不存在则添加）
     */
    public mutating func toggle(value: Element) {
        if let index = indexOf(value) {
            removeAtIndex(index)
        } else {
            append(value)
        }
    }
    
}

public extension Array {
    
    /**
     避免数组越界，安全返回 nil。即避免 arr[i] 抛出 out of range.
     */
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
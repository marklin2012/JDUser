//
//  JDNSNumber.swift
//  JDUtilDemo
//
//  Created by O2.LinYi on 15/12/24.
//  Copyright © 2015年 jd.com. All rights reserved.
//

import Foundation

public func + (left: NSNumber, right: NSNumber) -> NSNumber {
    return left.doubleValue + right.doubleValue
}

public func - (left: NSNumber, right: NSNumber) -> NSNumber {
    return left.doubleValue - right.doubleValue
}

public func * (left: NSNumber, right: NSNumber) -> NSNumber {
    return left.doubleValue * right.doubleValue
}

public func / (left: NSNumber, right: NSNumber) -> NSNumber {
    return left.doubleValue / right.doubleValue
}

public func += (inout left: NSNumber, right: NSNumber) {
    left = left.doubleValue + right.doubleValue
}

public func -= (inout left: NSNumber, right: NSNumber) {
    left = left.doubleValue - right.doubleValue
}

public func *= (inout left: NSNumber, right: NSNumber) {
    left = left.doubleValue * right.doubleValue
}

public func /= (inout left: NSNumber, right: NSNumber) {
    left = left.doubleValue / right.doubleValue
}

prefix public func ++ (inout operand: NSNumber) -> NSNumber {
    operand = operand + 1.0
    return operand
}

postfix public func ++ (inout operand: NSNumber) -> NSNumber {
    let previousOperand = operand;
    ++operand
    return previousOperand
}

prefix public func -- (inout operand: NSNumber) -> NSNumber {
    operand = operand - 1.0
    return operand
}

postfix public func -- (inout operand: NSNumber) -> NSNumber {
    let previousOperand = operand;
    --operand
    return previousOperand
}
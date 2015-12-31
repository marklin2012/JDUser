//
//  JDRandom.swift
//  JDUtilDemo
//
//  Created by O2.LinYi on 15/12/24.
//  Copyright © 2015年 jd.com. All rights reserved.
//

import UIKit

// MARK: - From https://github.com/thellimist/SwiftRandom
public extension Int {
    public static func random(lower: Int = 0, _ upper: Int = 100) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
}

public extension Double {
    public static func random(lower: Double = 0, _ upper: Double = 100) -> Double {
        return (Double(arc4random()) / 0xFFFFFFFF) * (upper - lower) + lower
    }
}

public extension Float {
    public static func random(lower: Float = 0, _ upper: Float = 100) -> Float {
        return (Float(arc4random()) / 0xFFFFFFFF) * (upper - lower) + lower
    }
}

public extension CGFloat {
    public static func random(lower: CGFloat = 0, _ upper: CGFloat = 1) -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (upper - lower) + lower
    }
}

public extension NSDate {
    public static func randomWithinDaysBeforeToday(days: Int) -> NSDate {
        let today = NSDate()
        
        guard let gregorian = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian) else {
            print("no calendar \"NSCalendarIdentifierGregorian\" found")
            return today
        }
        
        let r1 = arc4random_uniform(UInt32(days))
        let r2 = arc4random_uniform(UInt32(23))
        let r3 = arc4random_uniform(UInt32(23))
        let r4 = arc4random_uniform(UInt32(23))
        
        let offsetComponents = NSDateComponents()
        offsetComponents.day = Int(r1) * -1
        offsetComponents.hour = Int(r2)
        offsetComponents.minute = Int(r3)
        offsetComponents.second = Int(r4)
        
        guard let rndDate1 = gregorian.dateByAddingComponents(offsetComponents, toDate: today, options: []) else {
            print("randoming failed")
            return today
        }
        return rndDate1
    }
    
    public static func random() -> NSDate {
        let randomTime = NSTimeInterval(arc4random_uniform(UInt32.max))
        return NSDate(timeIntervalSince1970: randomTime)
    }
    
}

public extension UIColor {
    public static func random(randomAlpha: Bool = false) -> UIColor {
        let randomRed = CGFloat.random()
        let randomGreen = CGFloat.random()
        let randomBlue = CGFloat.random()
        let alpha = randomAlpha ? CGFloat.random() : 1.0
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: alpha)
    }
}
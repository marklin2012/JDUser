//
//  JDImage.swift
//  JDUtilDemo
//
//  Created by O2.LinYi on 15/12/24.
//  Copyright © 2015年 jd.com. All rights reserved.
//

import UIKit

public extension UIImage {
    public static func dataFromUrl (string: String, block: (UIImage?) -> Void) {
        if let url = NSURL(string: string) {
            dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
                if let data = NSData(contentsOfURL: url) {
                    dispatch_async(dispatch_get_main_queue()) {
                        block(UIImage(data: data))
                    }
                }
            }
        }
    }
}

public extension UIImage {
    public func resize(size: CGSize) -> UIImage {
        var newSize: CGSize = CGSizeZero
        
        if (self.size.width / size.width) < (self.size.height / size.height) {
            newSize = CGSizeMake(self.size.width, size.height * (self.size.width / size.width))
        }
        else {
            newSize = CGSizeMake(size.width * (self.size.height / size.height), self.size.height)
        }
        
        var cropRect: CGRect = CGRectZero
        cropRect.origin.x = (self.size.width - newSize.width) / 2.0
        cropRect.origin.y = (self.size.height - newSize.height) / 2.0
        cropRect.size = newSize
        
        guard let croppedImageRef: CGImageRef = CGImageCreateWithImageInRect(self.CGImage, cropRect) else {
            return self
        }
        
        let croppedImage: UIImage = UIImage(CGImage: croppedImageRef)
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), false, 0.0)
        croppedImage.drawInRect(CGRectMake(0.0, 0.0, size.width, size.height))
        let scaledImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
}
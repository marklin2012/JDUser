//
//  JDCaChe.swift
//  JDUtilDemo
//
//  Created by O2.LinYi on 15/12/24.
//  Copyright © 2015年 jd.com. All rights reserved.
//

import Foundation
import SDWebImage

public struct Cache {
    
    // 公共图片缓存（用例截图、用户头像缩略图等）
    //    static let sharedImageCache = SDImageCache(namespace: "sharedImageCache")
    public static let sharedImageCache = SDImageCache.sharedImageCache()
    
    // 用户图片缓存（头像、背景等）
    public static let userImageCache = SDImageCache(namespace: "userImageCache")
    
    public struct Assets {
        static let WechatLogo = UIImage(named: "wechat", inBundle: nil, compatibleWithTraitCollection: nil)
        static let wechatMomentsLogo = UIImage(named: "wechat_moments", inBundle: nil, compatibleWithTraitCollection: nil)
        static let QQLogo = UIImage(named: "qq", inBundle: nil, compatibleWithTraitCollection: nil)
    }
}
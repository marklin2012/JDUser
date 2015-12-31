//
//  QiniuImage.swift
//  JDUserDemo
//
//  Created by O2.LinYi on 15/12/31.
//  Copyright © 2015年 jd.com. All rights reserved.
//

import Foundation

public class QiniuImage {
    
    public enum SupportedImageType: String {
        case JPG = "jpg"
        case GIF = "gif"
        case PNG = "png"
        case WEBP = "webp"
    }
    
    public enum ImageQuality: Int {
        case Low = 20
        case Medium = 50
        case High = 80
        case Best = 100
    }
    
    public enum ProcessingMode: Int {
        case Fixed = 1
        case Scale = 2
    }
    
    private struct Constants {
        static let ThumbnailEntry = "imageView"
    }
    
    /**
     返回一个指定规格的图片地址（简便方法）
     
     - parameter url:   原图地址
     - parameter width: 指定目标缩略图的宽度
     
     - returns: 图片地址
     */
    public static func parseURL (url: String, width: Int) -> String {
        return parseURL(url, mode: ProcessingMode.Scale, width: width, height: nil, quality: nil, format: nil)
    }
    
    /**
     返回一个指定规格的图片地址（简便方法）
     
     - parameter url:    原图地址
     - parameter height: 想要的图高度
     
     - returns: 图片地址
     */
    public static func parseURL (url: String, height: Int) -> String {
        return parseURL(url, mode: ProcessingMode.Scale, width: height, height: nil, quality: nil, format: nil)
    }
    
    /**
     返回一个指定规格的图片地址
     - link：[七牛图片API](http://docs.qiniu.com/api/v6/image-process.html#imageView)
     
     - parameter url:     原图地址
     - parameter mode:    图像缩略处理的模式
     - parameter width:   指定目标缩略图的宽度
     - parameter height:  指定目标缩略图的高度
     - parameter quality: 指定目标缩略图的图像质量
     - parameter format:  指定目标缩略图的输出格式
     
     - returns: 图片地址
     */
    public static func parseURL (var url: String, mode: ProcessingMode, width: Int?, height: Int?, quality: ImageQuality?, format: SupportedImageType?) -> String {
        url += "?\(Constants.ThumbnailEntry)/\(mode.rawValue)"
        
        if width != nil {
            url += "/w/\(width!)"
        }
        
        if height != nil {
            url += "/h/\(height!)"
        }
        
        if quality != nil {
            url += "/q/\(quality!.rawValue)"
        }
        
        if format != nil {
            url += "/format/\(format!.rawValue)"
        }
        
        return url
    }
}

//
//  AVFile.swift
//  JDUserDemo
//
//  Created by O2.LinYi on 15/12/31.
//  Copyright © 2015年 jd.com. All rights reserved.
//

import Foundation

import Foundation
import AVOSCloud
import SDWebImage

public extension AVFile {
    
    public func getThumbnail (mode mode: QiniuImage.ProcessingMode, width: Int?, height: Int?, block: (UIImage?) -> Void) {
        
        if self.url != nil {
            UIImage.dataFromUrl(
                QiniuImage.parseURL(self.url, mode: mode, width: width, height: height, quality: nil, format: nil),
                block: block)
        }
    }
    
    public func setSizeToMetaData (img: UIImage) {
        self.metaData.setValue(img.size.width, forKey: "width")
        self.metaData.setValue(img.size.height, forKey: "height")
    }
    
    public func getSize () -> CGSize {
        return CGSize(width: getWidth(), height: getHeight())
    }
    
    public func getWidth () -> CGFloat {
        let value = self.metaData.objectForKey("width")
        
        if value == nil {
            print("[warning] 当前文件的 metadata 中没有宽度, id: \(self.objectId)).")
            return -1
        } else {
            return value as! CGFloat
        }
    }
    
    public func getHeight () -> CGFloat {
        let value = self.metaData.objectForKey("height")
        
        if value == nil {
            print("[warning] 当前文件的 metadata 中没有高度, id: \(self.objectId)).")
            return -1
        } else {
            return value as! CGFloat
        }
    }
}

public extension AVFile {
    
    /**
     从缓存或者服务器获取图片，并缓存起来
     
     - parameter imageCache: 缓存仓库
     - parameter callback:   回调
     */
    public func getImageWithCaching (imageCache: SDImageCache, callback: (image: UIImage!) -> Void) {
        guard let url = self.url else {
            callback(image: nil)
            return
        }
        
        let cachedImage = imageCache.imageFromDiskCacheForKey(url)
        
        if cachedImage != nil {
            callback(image: cachedImage)
        } else {
            self.getDataInBackgroundWithBlock({ data, error in
                
                if error != nil {
//                    Log.debug("加载图片失败：\(error.localizedDescription)，地址为：\(url)")
                    callback(image: nil)
                    return
                }
                
                let image = UIImage(data: data)
                imageCache.storeImage(image, forKey: url, toDisk: true)
                callback(image: image)
            })
        }
    }
}
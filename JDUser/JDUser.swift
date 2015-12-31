//
//  JDUser.swift
//  JDUserDemo
//
//  Created by O2.LinYi on 15/12/31.
//  Copyright © 2015年 jd.com. All rights reserved.
//


import Foundation
import AVOSCloud
import JDUtil

let defaultPassWord = "jdc"

public enum JDUserStatus: String {
    case Completed = "completed"
}

public enum JDUserType: String {
    case QQ = "qq"
    case Weixin = "weixin"
    case Local = "local"
}

public class JDUser: AVUser {
    
    static var storageUser: JDUser?
    
    @NSManaged var status: String
    
    @NSManaged var nickname: String // 昵称
    
    @NSManaged var avatar: AVFile? //头像
    
    @NSManaged var desc: String //描述
    
    @NSManaged var banner: AVFile? //背景
    
    @NSManaged var type: String // 登录方式
    
    @NSManaged var signature: String // 签名
    
    @NSManaged var sex: Int
}

public extension JDUser {
    
    /**
     从缓存或者服务器获取头像，并缓存起来
     
     - parameter callback: 回调
     */
    public func getAvatar (callback: (image: UIImage!) -> Void) {
        
        guard let avatar = self.avatar else {
            callback(image: nil)
            return
        }
        
        avatar.getImageWithCaching(Cache.userImageCache, callback: callback)
    }
    
    /**
     从缓存或者服务器获取背景，并缓存起来
     
     - parameter callback: 回调
     */
    public func getBanner (callback: (image: UIImage!) -> Void) {
        
        guard let banner = self.banner else {
            callback(image: nil)
            return
        }
        
        banner.getImageWithCaching(Cache.userImageCache, callback: callback)
    }
}

public extension JDUser {
    
    public func setOpenIDPassword () {
        if self.type != JDUserType.Local.rawValue {
            self.password = defaultPassWord
        }
    }
    
    /**
     登录
     
     - parameter successCallback: 回调方法
     - parameter errorCallback:   回调方法
     */
    public func login(callback: (JDUser!, NSError!) -> Void) {
        setOpenIDPassword()
        
        JDUser.logInWithUsernameInBackground(self.username, password: self.password) {
            user, error in
            if error != nil || user == nil {
                callback(nil, error)
                return
            }
            
            let user = user as! JDUser
            user.bindDevice()
            callback(user, nil)
        }
    }
    
    /**
     是否已经被注册
     */
    public func isRegist() -> Bool {
        let query = JDUser.query()
        query.whereKey("username", equalTo: self.username)
        
        let count = query.countObjects()
        return count > 0
    }
    
    /**
     是否已经被注册
     */
    public func isRegist(callback: (Bool, NSError!) -> Void) {
        let query = JDUser.query()
        query.whereKey("username", equalTo: self.username)
        
        query.countObjectsInBackgroundWithBlock { (count, error) -> Void in
            callback(count > 0, error)
        }
    }
    
    /**
     登录或注册后，绑定该设备和当前用户的关系
     */
    public func bindDevice () {
        let currentInstallation = AVInstallation.currentInstallation()
        // 这里存用户 id 而不是 pointer，是因为发现存 pointer 的话，值删除不了
        currentInstallation.setObject(self.objectId, forKey: "atUser")
        currentInstallation.saveInBackground()
        print("bind user: \(self.objectId), device: \(currentInstallation.deviceToken)")
    }
    
    /**
     注销时，取消绑定该设备和当前用户的关系
     */
    public func unbindDevice () {
        let currentInstallation = AVInstallation.currentInstallation()
        currentInstallation.setObject("", forKey: "atUser")
        currentInstallation.saveInBackground()
        print("unbind user: \(AVUser.currentUser().objectId), device: \(currentInstallation.deviceToken)")
    }
    
    /**
     更新所有用户 暂时不可用
     
     - parameter querys
     - parameter files
     */
    public static func undateAll(querys: Array<QueryCondition>, files: Dictionary<String, AnyObject>){
        var query: AVQuery = JDUser.query()
        
        query = convertQuery(querys, query: query)!
        
        query.findObjectsInBackgroundWithBlock({
            (list, error) in
            if(error == nil){
                for var i = 0; i < list.count; ++i{
                    print(list[i])
                    //JDUser.undateById(list[i].ObjectId, files)
                }
            }
        })
    }
    
    /**
     用户不支持修改别人信息，所以此方法用不上
     
     - parameter objectId:        查找的单条objectid
     - parameter files:           修改的键值对
     - parameter successcallback: 修改成功回调
     - parameter errorcallback:   修改失败回调
     */
    public static func undateById(objectId: String, files: Dictionary<String, AnyObject>, successcallback: () -> Void, errorcallback: (String) -> Void){
        let query = JDUser.query()
        query.getObjectInBackgroundWithId(objectId, block: {
            (object, error) in
            if(error == nil){
                for (k, v) in files {
                    object.setValue(v, forKey: k)
                    print("\(k) ->\(v)" )
                    print(object)
                }
                object.saveInBackgroundWithBlock({
                    (succeeded, error) in
                    if(succeeded){
                        successcallback()
                    }else{
                        print(succeeded)
                        print(error)
                        errorcallback("保存失败")
                    }
                })
            }
        })
    }
    
    /**
     获取用户列表
     
     - parameter querys
     - parameter successcallback
     - parameter errorcallback
     */
    public static func userList(querys: Array<QueryCondition>, successcallback: (Array<AnyObject>) -> Void, errorcallback: (String) -> Void) ->Void {
        var query: AVQuery = JDUser.query()
        
        query = convertQuery(querys, query: query)!
        
        query.findObjectsInBackgroundWithBlock({
            (list, error) in
            if(error == nil){
                successcallback(list)
            }else{
                errorcallback("用户列表为空")
            }
        })
    }
    
    override public static func logOut () {
        JDUser.currentUser()?.unbindDevice()
        super.logOut()
    }
}

//
//  UserAccount.swift
//  iOSDesign
//
//  Created by sam on 16/3/15.
//  Copyright © 2016年 sam. All rights reserved.
//

import UIKit

class UserAccount: NSObject {
    //采用OAuth授权方式为必填参数，OAuth授权后获得。
    var access_token:String?
    //access_token的声明周期，单位是 秒
    var expires_in:NSTimeInterval=0
    //需要查询的用户ID。
    var uid:String?
    
    
    //用户头像地址（大图），180×180像素
    var avatar_large:String?
    //友好显示名称
    var name:String?

    //KVC设置初始值
    init(dict :[ String :AnyObject] ) {
        //super实例化
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    //把字符串转换成字典
    override var description:String{
        let keys=["access_token","expires_in","uid","avatar_large","name"]
        return dictionaryWithValuesForKeys(keys).description
    }

}

//
//  MyResponse.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/4/13.
//  Copyright © 2017年 xigk. All rights reserved.
//

import Foundation
import HandyJSON
import Alamofire

// 处理收到的协议
func rootResponse(strjson:String, id:PBID) {
    switch id {
    case PBID.registerTourist:
        respRegisterTourist(strjson: strjson)
    case PBID.registerBindPhone:
        respRegisterPhone(strjson: strjson)
    case PBID.loginPhone:
        respLoginPhone(strjson: strjson)
        
    default:
        print("no protocol")
    }
}

// 游客注册返回值 
// {"code":"0","token":"AKAqng6ELdPqpVAk7dVa"}
func respRegisterTourist(strjson:String) {
    if let data = resRegisterTouristData.deserialize(from: strjson) {
        let code = data.code
        let token:String = data.token!
        if code == 0 {
            nowGlobalSet?.token = token
            appDelegate.saveContext()
        }
    }
}

// 注册绑定电话
func respRegisterPhone(strjson:String){
    if let data = resRegisterBindTouristData.deserialize(from: strjson) {
        let code = data.code
        let token:String = data.token!
        if code == 0 {
            nowGlobalSet?.token = token
            appDelegate.saveContext()
        }
    }
}

// 电话登录
func respLoginPhone(strjson:String){
    if let data = resLoginData.deserialize(from: strjson) {
        let code = data.code
        let token:String = data.token!
        if code == 0 {
            nowGlobalSet?.token = token
            nowGlobalSet?.uid = data.uid
            appDelegate.saveContext()
        }
    }
}


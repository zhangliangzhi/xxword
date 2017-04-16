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
    case PBID.loginTourist:
        // do nothing
        break
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
        let token = data.token
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
        let token = data.token
        if code == 0 {
            nowGlobalSet?.token = token
            appDelegate.saveContext()
        }
    }
}

// 电话登录
// {"code":"0","uid":"ps6ZwZ5KJz","token":"pM47FpoxIVbt11gRPKHd"}
func respLoginPhone(strjson:String){
    if let data = resLoginData.deserialize(from: strjson) {
        let code = data.code
        let token = data.token
        if code == 0 {
            nowGlobalSet?.token = token
            nowGlobalSet?.uid = data.uid
            appDelegate.saveContext()
        }
    }
}


// 错误提示
func TipsError(id:Int) {
    switch id {
    case 20:
        print("uid出错")
    case 21:
        print("手机格式出错")
    case 22:
        print("密码要大于6个字符")
    case 23:
        print("已经注册过了")
    case 24:
        print("电话号码已用过")
    case 30:
        print("账号或密码出错")
    case 31:
        print("账号请重新登录")
    default:
        print("def err")
    }
}

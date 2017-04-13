//
//  MyResponse.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/4/13.
//  Copyright © 2017年 xigk. All rights reserved.
//

import Foundation
import HandyJSON

// 处理收到的协议
func rootResponse(strjson:String, id:PBID) {
    switch id {
    case PBID.login:
        respLogin(strjson: strjson)
        
        
    default:
        print("no protocol")
    }
}

// 注册
func respLogin(strjson:String){
    
}

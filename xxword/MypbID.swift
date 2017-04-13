//
//  MypbID.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/4/13.
//  Copyright © 2017年 xigk. All rights reserved.
//

import Foundation
import HandyJSON

// 协议说明
enum PBID:Int,HandyJSONEnum {
    case register       = 101       // 注册
    case login          = 102       // 登入
    case changeName     = 103       // 改昵称
    case changePwd      = 104       // 修改密码
    case tourist        = 105       // 游客注册
    
    
}

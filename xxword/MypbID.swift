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
    case registerPhonePwd       = 101       // 注册
    case registerTourist        = 102       // 注册
    case registerBindPhone      = 103       // 注册
    
    case loginPhone             = 201       // 手机登入
    case loginTourist           = 202       // 游客登入
    
    case changeName             = 300       // 改昵称
    case changePwd              = 302       // 修改密码
    case tourist                = 105       // 游客注册
    
    
}

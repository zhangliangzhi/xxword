//
//  MyProtocol.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/4/13.
//  Copyright © 2017年 xigk. All rights reserved.
//

import Foundation
import HandyJSON

// 游客注册


// 注册
struct reqRegisterData: HandyJSON {
    var id: PBID = PBID.register            // 协议id
    var phoneID: String?
    var pwd: String?
}
struct resRegisterData: HandyJSON {
    var userid: Int?
}

// 登录
struct reqLoginData: HandyJSON {
    var id: PBID = PBID.login
    var phoneID: String?
    var pwd: String?
}

// 改名
struct reqChangeNameData: HandyJSON {
    var id: PBID = PBID.changeName
    var name: String?
}

// 改密码
struct reqChangePwdData: HandyJSON{
    var id: PBID = PBID.changePwd
    var pwd: String?
}



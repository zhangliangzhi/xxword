//
//  MyProtocol.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/4/13.
//  Copyright © 2017年 xigk. All rights reserved.
//

import Foundation
import HandyJSON

// code
struct resRegisterCode:HandyJSON {
    var code:Int?
}

// 游客注册
// {"code":"0","token":"AKAqng6ELdPqpVAk7dVa"}
struct resRegisterTouristData:HandyJSON {
    var code:Int?
    var token:String?
    var uid:String?
}

// 游客绑定
struct resRegisterBindTouristData:HandyJSON {
    var code:Int?
    var token:String?
}

// 登录
struct resLoginData:HandyJSON {
    var code:Int?
    var uid:String?
    var token:String?
}

// 登录信息2 {"state":0,"isVIP":false,"getVipTime":1495551803,"code":0}
struct resInfoFromSvr:HandyJSON {
    var code:Int?
    var uid:String?
    var state:Int?
    var isVIP:Bool?
    var getVipTime:Int?
}

// 排行榜 数组格式 {"uid":"U7CDbSzrAa","name":"\u6e38\u5ba2","score":"0","useTime":"9","indexPage":"0","curTime":1495565984},{
class oneRank: HandyJSON {
    var uid:String?
    var name:String?
    var score:Int?
    var useTime:Int?
    var curTime:Int?
    var indexPage:Int?
    
    required init() {}
}



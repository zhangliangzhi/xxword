//
//  MeViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/5/21.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit

class MeViewController: UIViewController {

    var rootv: UIView!
    var nickName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BG1_COLOR
        self.title = "我的账号"
        
        rootv = UIView()
        self.view.addSubview(rootv)
        rootv.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(64)
            make.bottom.equalTo(self.view)
        }
        
        initUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func initUI() {
        
    }
}

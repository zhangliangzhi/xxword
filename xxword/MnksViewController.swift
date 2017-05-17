//
//  MnksViewController.swift
//  xxword
//  模拟考试
//  Created by ZhangLiangZhi on 2017/5/17.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit

class MnksViewController: UIViewController {
    var rootv: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BG1_COLOR
        self.title = "考试比赛"
        
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

    func initUI() {
        let buttonKaos50 = BootstrapBtn(frame: CGRect(x: 0, y: 0, width: 50, height: 30), btButtonType: .Info)
        rootv.addSubview(buttonKaos50)
    }
    
    func callbackGo50() {
        
    }
    
    func callbackGo100() {
        
    }
}

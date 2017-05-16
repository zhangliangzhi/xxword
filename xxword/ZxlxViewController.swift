//
//  ZxlxViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/5/16.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit

class ZxlxViewController: UIViewController {

    var rootv:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BG1_COLOR
        // Do any additional setup after loading the view.
        
        self.title = "专项练习"
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initUI() {
        // 1. adj
        let buttonAdj = BootstrapBtn(frame: CGRect.init(x: 0, y: 0, width: 50, height: 30), btButtonType: .Warning)
        rootv.addSubview(buttonAdj)
        buttonAdj.snp.makeConstraints { (make) in
            make.width.equalTo(280)
            make.centerX.equalTo(rootv)
            make.height.equalTo(38)
            make.top.equalTo(rootv).offset(20)
        }
        buttonAdj.setTitle("adj.", for: .normal)
        buttonAdj.addTarget(self, action: #selector(callbackAdj), for: .touchUpInside)
        
        // 2. adv
        let buttonAdv = BootstrapBtn(frame: CGRect.init(x: 0, y: 0, width: 50, height: 30), btButtonType: .Warning)
        rootv.addSubview(buttonAdv)
        buttonAdv.snp.makeConstraints { (make) in
            make.width.height.equalTo(buttonAdj)
            make.centerX.equalTo(buttonAdj)
            make.top.equalTo(buttonAdj.snp.bottom).offset(18)
        }
        buttonAdv.setTitle("adv.", for: .normal)
        buttonAdv.addTarget(self, action: #selector(callbackAdv), for: .touchUpInside)
        
        // 3. vt
        let buttonVt = BootstrapBtn(frame: CGRect.init(x: 0, y: 0, width: 50, height: 30), btButtonType: .Success)
        rootv.addSubview(buttonVt)
        buttonVt.snp.makeConstraints { (make) in
            make.width.height.equalTo(buttonAdj)
            make.centerX.equalTo(buttonAdj)
            make.top.equalTo(buttonAdv.snp.bottom).offset(18)
        }
        buttonVt.setTitle("vt.", for: .normal)
        buttonVt.addTarget(self, action: #selector(callbackVt), for: .touchUpInside)
        
        // 4. vi
        let buttonVi = BootstrapBtn(frame: CGRect.init(x: 0, y: 0, width: 50, height: 30), btButtonType: .Success)
        rootv.addSubview(buttonVi)
        buttonVi.snp.makeConstraints { (make) in
            make.width.height.equalTo(buttonAdj)
            make.centerX.equalTo(buttonAdj)
            make.top.equalTo(buttonVt.snp.bottom).offset(18)
        }
        buttonVi.setTitle("vi.", for: .normal)
        buttonVi.addTarget(self, action: #selector(callbackVi), for: .touchUpInside)
        
        
        // 5. n
        let buttonN = BootstrapBtn(frame: CGRect.init(x: 0, y: 0, width: 50, height: 30), btButtonType: .Info)
        rootv.addSubview(buttonN)
        buttonN.snp.makeConstraints { (make) in
            make.width.height.equalTo(buttonAdj)
            make.centerX.equalTo(buttonAdj)
            make.top.equalTo(buttonVi.snp.bottom).offset(18)
        }
        buttonN.setTitle("n.", for: .normal)
        buttonN.addTarget(self, action: #selector(callbackN), for: .touchUpInside)
    }
    
    func callbackAdj() {
        
    }

    func callbackAdv() {
        
    }
    
    func callbackVt() {
        
    }
    
    func callbackVi() {
        
    }
    
    func callbackN() {
        
    }
}

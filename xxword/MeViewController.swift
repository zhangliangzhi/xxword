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
    var labelNickName:UILabel!
    var labelIsVip:UILabel!
//    var outSignupButton:BootstrapBtn!
    var outLoginButton:BootstrapBtn!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BG1_COLOR
        self.title = "我的"
        
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
        changeTxt()
    }
    
    func changeTxt() {
        labelNickName.text = nowGlobalSet?.nickName
        if (nowGlobalSet?.isVIP)! {
            labelIsVip.text = "是"
        }else {
            labelIsVip.text = "否"
        }
        
        if nowGlobalSet?.phone == "" {
            outLoginButton.setTitle("登录", for: .normal)
        }else {
            outLoginButton.setTitle("立刻学习", for: .normal)
//            outLoginButton.isHidden = true
        }
        
    }
    
    func initUI() {
        
        // 愿景
        let labelIcon = UILabel()
        rootv.addSubview(labelIcon)
        labelIcon.snp.makeConstraints { (make) in
            make.centerX.equalTo(rootv).offset(20)
//            make.bottom.equalTo(rootv).offset(-80)
            make.centerY.equalTo(rootv).offset(20)
        }
        labelIcon.text = "不上培训班, 爱上玩单词✅"
        labelIcon.textColor = WARN_COLOR
        
        let outIconButton = UIButton(type: .system)
        outIconButton.setBackgroundImage(UIImage(named: "icon"), for: .normal)
        rootv.addSubview(outIconButton)
        outIconButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(labelIcon)
            make.right.equalTo(labelIcon.snp.left).offset(-8)
            make.width.height.equalTo(38)
        }
        outIconButton.addTarget(self, action: #selector(btnGoIcon), for: .touchUpInside)
        
        
        // 1
        let labelnctitle = UILabel()
        rootv.addSubview(labelnctitle)
        labelnctitle.snp.makeConstraints { (make) in
            make.top.equalTo(rootv).offset(20)
            make.centerX.equalTo(rootv).offset(-30)
        }
        labelnctitle.text = "名字: "
        labelnctitle.textColor = WZ2_COLOR
        labelnctitle.textAlignment = .right
        
        labelNickName = UILabel()
        rootv.addSubview(labelNickName)
        labelNickName.snp.makeConstraints { (make) in
            make.top.equalTo(labelnctitle)
            make.left.equalTo(labelnctitle.snp.right).offset(5)
        }
        labelNickName.text = nowGlobalSet?.nickName
        labelNickName.textColor = WZ1_COLOR
        labelNickName.textAlignment = .left
        
        // 2
        let labelVipTitle = UILabel()
        rootv.addSubview(labelVipTitle)
        labelVipTitle.snp.makeConstraints { (make) in
            make.top.equalTo(labelnctitle.snp.bottom).offset(20)
            make.centerX.equalTo(labelnctitle)
        }
        labelVipTitle.text = "是否VIP会员: "
        labelVipTitle.textColor = WZ2_COLOR
        labelVipTitle.textAlignment = .right
        
        labelIsVip = UILabel()
        rootv.addSubview(labelIsVip)
        labelIsVip.snp.makeConstraints { (make) in
            make.top.equalTo(labelVipTitle)
            make.left.equalTo(labelVipTitle.snp.right).offset(5)
        }
        labelIsVip.text = "否"
        labelIsVip.textColor = WZ1_COLOR
        labelIsVip.textAlignment = .left
        
        let vipButton = UIButton(type: .system)
        vipButton.setBackgroundImage(UIImage(named: "hy"), for: .normal)
        rootv.addSubview(vipButton)
        vipButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(labelVipTitle)
            make.right.equalTo(labelVipTitle.snp.left)
            make.width.height.equalTo(50)
        }
        vipButton.addTarget(self, action: #selector(btnGoVip), for: .touchUpInside)
        
        /*
        // 立即注册
        outSignupButton = BootstrapBtn(frame: CGRect(x: 0, y: 0, width: 150, height: 40), btButtonType: .Info)
        rootv.addSubview(outSignupButton)
        outSignupButton.snp.makeConstraints { (make) in
            make.width.equalTo(rootv).multipliedBy(0.618)
            make.height.equalTo(40)
            make.centerX.equalTo(rootv)
            make.top.equalTo(labelVipTitle.snp.bottom).offset(20)
        }
        outSignupButton.setTitle("立即注册", for: .normal)
        outSignupButton.addTarget(self, action: #selector(btnGoSignUp), for: .touchUpInside)
        */
        
        // 登入按钮
        outLoginButton = BootstrapBtn(frame: CGRect(x: 0, y: 0, width: 150, height: 40), btButtonType: .Success)
        rootv.addSubview(outLoginButton)
        outLoginButton.snp.makeConstraints { (make) in
            make.width.equalTo(rootv).multipliedBy(0.618)
            make.height.equalTo(40)
            make.centerX.equalTo(rootv)
            make.top.equalTo(labelVipTitle.snp.bottom).offset(30)
        }
        outLoginButton.setTitle("登录", for: .normal)
        outLoginButton.addTarget(self, action: #selector(btnGoSignIn), for: .touchUpInside)
        
        // 改名按钮
        let outEditNameButton = BootstrapBtn(frame: CGRect(x: 0, y: 0, width: 60, height: 26), btButtonType: .Primary)
        rootv.addSubview(outEditNameButton)
        outEditNameButton.snp.makeConstraints { (make) in
            make.width.equalTo(60)
            make.height.equalTo(26)
            make.right.equalTo(labelnctitle.snp.left)
            make.centerY.equalTo(labelnctitle)
        }
        outEditNameButton.setTitle("改名", for: .normal)
        outEditNameButton.addTarget(self, action: #selector(btnEditName), for: .touchUpInside)
        
    }
    
    func btnGoSignUp() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    func btnGoSignIn() {
        if nowGlobalSet?.phone == "" {
            navigationController?.pushViewController(LoginViewController(), animated: true)
        }else {
//            TipsSwift.showCenterWithText("已经登录", duration: 3)
            appDelegate.window?.rootViewController?.removeFromParentViewController()
            appDelegate.window?.rootViewController = StudyTabBarController()
        }
        
    }
    
    func btnGoVip() {
        TipsSwift.showCenterWithText("订购VIP会员\n可无限制使用[象形单词]app", duration: 3)
    }
    
    func btnEditName() {
        navigationController?.pushViewController(ChangeNameViewController(), animated: true)
    }
    
    func btnGoIcon() {
        TipsSwift.showCenterWithText("象形单词 v1.0", duration: 1)
    }
    
}

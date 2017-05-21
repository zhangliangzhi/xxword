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
    var outSignupButton:BootstrapBtn!
    var outLoginButton:BootstrapBtn!
    
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
        let imgIcon = UIImageView(image: UIImage(named: "icon"))
        rootv.addSubview(imgIcon)
        imgIcon.snp.makeConstraints { (make) in
            make.center.equalTo(rootv)
        }
        let labelIcon = UILabel()
        rootv.addSubview(labelIcon)
        labelIcon.snp.makeConstraints { (make) in
            make.centerX.equalTo(imgIcon)
            make.top.equalTo(imgIcon.snp.bottom).offset(20)
        }
        labelIcon.text = "不上培训班\n爱上玩单词"
        labelIcon.textColor = WZ2_COLOR
        labelIcon.numberOfLines = 0
        
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
        labelNickName.text = "游客"
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
        
        // 立即注册
        outSignupButton = BootstrapBtn(frame: CGRect(x: 0, y: 0, width: 150, height: 40), btButtonType: .Info)
        rootv.addSubview(outSignupButton)
        outSignupButton.snp.makeConstraints { (make) in
            make.width.equalTo(rootv).multipliedBy(0.618)
            make.height.equalTo(40)
            make.centerX.equalTo(rootv)
            make.top.equalTo(labelVipTitle.snp.bottom).offset(40)
        }
        outSignupButton.setTitle("立即注册", for: .normal)
        outSignupButton.addTarget(self, action: #selector(btnGoSignUp), for: .touchUpInside)
        
        // 登入按钮
        outLoginButton = BootstrapBtn(frame: CGRect(x: 0, y: 0, width: 150, height: 40), btButtonType: .Success)
        rootv.addSubview(outLoginButton)
        outLoginButton.snp.makeConstraints { (make) in
            make.width.equalTo(rootv).multipliedBy(0.618)
            make.height.equalTo(40)
            make.centerX.equalTo(rootv)
            make.top.equalTo(outSignupButton.snp.bottom).offset(30)
        }
        outLoginButton.setTitle("登录", for: .normal)
        outLoginButton.addTarget(self, action: #selector(btnGoSignIn), for: .touchUpInside)
        
        let vipButton = UIButton(type: .system)
        vipButton.setBackgroundImage(UIImage(named: "hy"), for: .normal)
        rootv.addSubview(vipButton)
        vipButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(labelVipTitle)
            make.centerX.equalTo(rootv).multipliedBy(0.3)
        }
        vipButton.addTarget(self, action: #selector(btnGoVip), for: .touchUpInside)
    }
    
    func btnGoSignUp() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    func btnGoSignIn() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    func btnGoVip() {
        TipsSwift.showCenterWithText("订购VIP会员\n无限制使用[象形单词]app", duration: 3)
    }
    
}

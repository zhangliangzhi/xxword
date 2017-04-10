//
//  LoginViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/4/10.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    var v:UIView!
    var outNumTextField:UITextField!
    var outPwdTextField:UITextField!
    var outLoginButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        v = UIView()
        self.view.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.view)
            make.center.equalTo(self.view)
        }
        v.backgroundColor = UIColor.darkGray
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        initLgv()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initLgv() {
        // phone number
        outNumTextField = UITextField()
        v.addSubview(outNumTextField)
        outNumTextField.snp.makeConstraints { (make) in
            make.width.equalTo(v).multipliedBy(0.8)
            make.height.equalTo(40)
            make.top.equalTo(v).offset(150)
            make.centerX.equalTo(v)
        }
        outNumTextField.delegate = self
        outNumTextField.keyboardType = .numbersAndPunctuation
        outNumTextField.spellCheckingType = .no
        outNumTextField.autocorrectionType = .no
        outNumTextField.returnKeyType = .next
        outNumTextField.borderStyle = .roundedRect
        outNumTextField.backgroundColor = UIColor.white
        outNumTextField.autocapitalizationType = .none
        outNumTextField.placeholder = "输入手机号码"
        
        outPwdTextField = UITextField()
        v.addSubview(outPwdTextField)
        outPwdTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(v)
            make.width.equalTo(v).multipliedBy(0.8)
            make.height.equalTo(40)
            make.top.equalTo(outNumTextField.snp.bottom).offset(8)
        }
        outPwdTextField.delegate = self
        outPwdTextField.keyboardType = .asciiCapable
        outPwdTextField.spellCheckingType = .no
        outPwdTextField.autocorrectionType = .no
        outPwdTextField.returnKeyType = .done
        outPwdTextField.borderStyle = .roundedRect
        outPwdTextField.backgroundColor = UIColor.white
        outPwdTextField.autocapitalizationType = .none
        outPwdTextField.placeholder = "输入密码"
        
        // image
        
        let numImage = UIImageView(frame: CGRect(x: 6, y: 0, width: 25, height: 25))
        numImage.image = UIImage(named: "number")
        outNumTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 25))
        outNumTextField.leftView?.addSubview(numImage)
        outNumTextField.leftViewMode = .always

        let pwdImage = UIImageView(frame: CGRect(x: 6, y: 0, width: 25, height: 25))
        pwdImage.image = UIImage(named: "password")
        outPwdTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 25))
        outPwdTextField.leftViewMode = .always
        outPwdTextField.leftView?.addSubview(pwdImage)
    }

}

//
//  LoginViewController.swift
//  xxword
//  登录界面
//  Created by ZhangLiangZhi on 2017/4/10.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit
import SnapKit
import Toast_Swift
import Foundation
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate {

    var v:UIView!
    var outNumTextField:UITextField!
    var outPwdTextField:UITextField!
    var outLoginButton:UIButton!
    var outSignUpButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        v = UIView()
        self.view.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.view)
            make.center.equalTo(self.view)
        }
//        v.backgroundColor = UIColor.darkGray
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        initLgv()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        outNumTextField.resignFirstResponder()
        outPwdTextField.resignFirstResponder()
    }
    
    func initLgv() {
        // phone number
        outNumTextField = UITextField()
        v.addSubview(outNumTextField)
        outNumTextField.snp.makeConstraints { (make) in
            make.width.equalTo(v).multipliedBy(0.8)
            make.height.equalTo(40)
            make.top.equalTo(v).offset(120)
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
        outNumTextField.placeholder = "请输入手机号码"
        
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
        outPwdTextField.placeholder = "请输入密码"
        outPwdTextField.isSecureTextEntry = true
        
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
        
        // close btn
        let numBtn = UIButton(frame: CGRect(x: -1, y: 0, width: 25, height: 25))
        numBtn.setBackgroundImage(UIImage(named: "close"), for: .normal)
        outNumTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 25))
        outNumTextField.rightView?.addSubview(numBtn)
        outNumTextField.rightViewMode = .whileEditing
        numBtn.addTarget(self, action: #selector(delNumTextField), for: .touchUpInside)
        
        let pwdBtn = UIButton(frame: CGRect(x: -1, y: 0, width: 25, height: 25))
        pwdBtn.setBackgroundImage(UIImage(named: "close"), for: .normal)
        outPwdTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 25))
        outPwdTextField.rightView?.addSubview(pwdBtn)
        outPwdTextField.rightViewMode = .whileEditing
        pwdBtn.addTarget(self, action: #selector(delPwdTextField), for: .touchUpInside)
        
        // first responder
//        outNumTextField.becomeFirstResponder()
        
        // 登入按钮
        outLoginButton = BootstrapBtn(frame: CGRect(x: 0, y: 0, width: 150, height: 40), btButtonType: .Success)
        v.addSubview(outLoginButton)
        outLoginButton.snp.makeConstraints { (make) in
            make.width.equalTo(outPwdTextField)
            make.height.equalTo(40)
            make.centerX.equalTo(outPwdTextField)
            make.top.equalTo(outPwdTextField.snp.bottom).offset(40)
        }
        outLoginButton.setTitle("登录", for: .normal)
        outLoginButton.addTarget(self, action: #selector(btnGoSignIn), for: .touchUpInside)
        
        // 注册按钮
        outSignUpButton = BootstrapBtn(frame: CGRect(x: 0, y: 0, width: 120, height: 30), btButtonType: .Info)
        v.addSubview(outSignUpButton)
        outSignUpButton.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(30)
            make.top.equalTo(outLoginButton.snp.bottom).offset(25)
            make.right.equalTo(outLoginButton).offset(-10)
        }
        outSignUpButton.setTitle("立即注册", for: .normal)
        outSignUpButton.addTarget(self, action: #selector(btnGoSignUp), for: .touchUpInside)
        
        // 右上角 注册按钮
        let rightBtn = UIBarButtonItem(title: "立即注册", style: .plain, target: self, action: #selector(btnGoSignUp))
        self.navigationItem.rightBarButtonItem = rightBtn
        
        outNumTextField.becomeFirstResponder()
    }
    
    func delNumTextField() {
        outNumTextField.text = ""
    }
    
    func delPwdTextField() {
        outPwdTextField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == outNumTextField {
            outPwdTextField.becomeFirstResponder()
        }else if textField == outPwdTextField {
            outPwdTextField.resignFirstResponder()
            // 输入完密码直接登录啊
            btnGoSignIn()
        }
        return true
    }

    // 登入
    func btnGoSignIn() {
        outPwdTextField.resignFirstResponder()
        outPwdTextField.resignFirstResponder()
        // 去除头尾空格
        var strNum:String = outNumTextField.text!
        strNum = strNum.trimmingCharacters(in: .whitespaces)
        var strPwd:String = outPwdTextField.text!
        strPwd = strPwd.trimmingCharacters(in: .whitespaces)
        
        // 不为空
        if strNum == "" {
            Toast("手机号码不能为空")
            return
        }
        // 手机是数字,香港手机8位数
        let num = Int64(strNum)
        if num == nil || num! < 10000000 || strNum.characters.count > 20{
            Toast("输入的是一个无效的手机号码")
            return
        }
        // 密码不为空
        if strPwd == "" {
            Toast("密码不能为空")
            return
        }
        if strPwd.characters.count < 6 || strPwd.characters.count > 20 {
            Toast("密码要大于6位数")
            return
        }

        netConnectSignIn(phone: strNum, pwd: strPwd)
    }

    
    func Toast(_ str:String) {
        self.view.makeToast(str, duration: 1.2, position: .init(x: self.view.bounds.size.width / 2.0, y: 100))
    }
    
    // 注册
    func btnGoSignUp() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    enum Validate {
        case email(_: String)
        case phoneNum(_: String)
        case carNum(_: String)
        case username(_: String)
        case password(_: String)
        case nickname(_: String)
        
        case URL(_: String)
        case IP(_: String)
        
        var isRight: Bool {
            var predicateStr:String!
            var currObject:String!
            switch self {
            case let .email(str):
                predicateStr = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
                currObject = str
            case let .phoneNum(str):
                predicateStr = "^((13[0-9])|(15[^4,\\D]) |(17[0,0-9])|(18[0,0-9]))\\d{8}$"
                currObject = str
            case let .carNum(str):
                predicateStr = "^[A-Za-z]{1}[A-Za-z_0-9]{5}$"
                currObject = str
            case let .username(str):
                predicateStr = "^[A-Za-z0-9]{6,20}+$"
                currObject = str
            case let .password(str):
                predicateStr = "^[a-zA-Z0-9]{6,20}+$"
                currObject = str
            case let .nickname(str):
                predicateStr = "^[\\u4e00-\\u9fa5]{4,8}$"
                currObject = str
            case let .URL(str):
                predicateStr = "^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$"
                currObject = str
            case let .IP(str):
                predicateStr = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
                currObject = str
            }
            
            let predicate =  NSPredicate(format: "SELF MATCHES %@" ,predicateStr)
            return predicate.evaluate(with: currObject)
        }
    }
    
    
    // 网络请求 手机密码登录
    func netConnectSignIn(phone:String, pwd:String) {
        outLoginButton.isUserInteractionEnabled = false
        outSignUpButton.isUserInteractionEnabled = false
        self.view.makeToastActivity(.center)
        let url = rootUrl + "login1.php"
        Alamofire.request(url, method: .get, parameters: ["phone": phone, "pwd": pwd]).responseString { (response) in
            
            self.outLoginButton.isUserInteractionEnabled = true
            self.outSignUpButton.isUserInteractionEnabled = true
            if response.result.isSuccess {
                let str:String = response.result.value!
                
                if let data = resLoginData.deserialize(from: str) {
                    let code = data.code
                    let token = data.token
                    if code == 0 {
                        nowGlobalSet?.phone = phone
                        nowGlobalSet?.pwd = pwd
                        nowGlobalSet?.token = token
                        nowGlobalSet?.uid = data.uid
                        appDelegate.saveContext()
                        // 登入成功,获取一下信息
                        HomeViewController.getInfo()
                        self.backV()
                    }else if code == 30{
                        TipsSwift.showCenterWithText("账号或密码出错", duration: 3)
                        self.outPwdTextField.resignFirstResponder()
                        self.outPwdTextField.text = ""
                    }else{
                        TipsSwift.showCenterWithText("登录出错", duration: 3)
                    }
                }else{
                    TipsSwift.showCenterWithText("网络出错", duration: 3)
                }
                
                self.view.hideToastActivity()
            }else {
                self.view.hideToastActivity()
                print("get protocol fail")
                TipsSwift.showCenterWithText("无法连接网络")
            }
        }

    }
    
    func backV() {
        navigationController?.popViewController(animated: true)
    }
    
    
    
}

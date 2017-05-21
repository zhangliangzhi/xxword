//
//  LoginViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/4/10.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit
import SnapKit
import Toast_Swift
import Foundation
import Alamofire

class ChangeNameViewController: UIViewController, UITextFieldDelegate {

    var v:UIView!
    var outNameTextField:UITextField!
    var outOkButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "修改名字"
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
        outNameTextField.resignFirstResponder()
    }
    
    func initLgv() {
        
        outNameTextField = UITextField()
        v.addSubview(outNameTextField)
        outNameTextField.snp.makeConstraints { (make) in
            make.width.equalTo(v).multipliedBy(0.8)
            make.height.equalTo(40)
            make.top.equalTo(v).offset(120)
            make.centerX.equalTo(v)
        }
        outNameTextField.delegate = self
        outNameTextField.keyboardType = .default
        outNameTextField.spellCheckingType = .no
        outNameTextField.autocorrectionType = .no
        outNameTextField.returnKeyType = .done
        outNameTextField.borderStyle = .roundedRect
        outNameTextField.backgroundColor = UIColor.white
        outNameTextField.autocapitalizationType = .none
        outNameTextField.placeholder = "修改名字"
        
        outNameTextField.text = nowGlobalSet?.nickName
        
        // close btn
        let numBtn = UIButton(frame: CGRect(x: -1, y: 0, width: 25, height: 25))
        numBtn.setBackgroundImage(UIImage(named: "close"), for: .normal)
        outNameTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 25))
        outNameTextField.rightView?.addSubview(numBtn)
        outNameTextField.rightViewMode = .whileEditing
        numBtn.addTarget(self, action: #selector(delNameTextField), for: .touchUpInside)
        
        // 登入按钮
        outOkButton = BootstrapBtn(frame: CGRect(x: 0, y: 0, width: 150, height: 40), btButtonType: .Success)
        v.addSubview(outOkButton)
        outOkButton.snp.makeConstraints { (make) in
            make.width.equalTo(v).multipliedBy(0.618)
            make.height.equalTo(40)
            make.centerX.equalTo(v)
            make.top.equalTo(outNameTextField.snp.bottom).offset(40)
        }
        outOkButton.setTitle("确定修改", for: .normal)
        outOkButton.addTarget(self, action: #selector(btnGoOK), for: .touchUpInside)
        
        outNameTextField.becomeFirstResponder()
    }
    
    func delNameTextField() {
        outNameTextField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        outNameTextField.resignFirstResponder()
        return true
    }

    // 确定
    func btnGoOK() {
        // 去除头尾空格
        var strNum:String = outNameTextField.text!
        strNum = strNum.trimmingCharacters(in: .whitespaces)
        
        // 不为空
        if strNum == "" {
            Toast(str: "名字不能为空")
            return
        }

//        netConnectChangeName(strNum)
        
        TipsSwift.showCenterWithText("改名成功")
        nowGlobalSet?.nickName = strNum
        appDelegate.saveContext()
        navigationController?.popViewController(animated: true)
    }

    
    func Toast(str:String) {
        self.view.makeToast(str, duration: 1.2, position: .init(x: self.view.bounds.size.width / 2.0, y: 100))
    }
    
    // 网络请求 修改名字
    func netConnectChangeName(_ name:String) {
        self.view.makeToastActivity(.center)
        let url = rootUrl + "changeName.php"
        let token:String = (nowGlobalSet?.token)!
        Alamofire.request(url, method: .get, parameters: ["name": name, "token":token]).responseString { (response) in
            if response.result.isSuccess {
                let str:String = response.result.value!
                nowGlobalSet?.nickName = name
                appDelegate.saveContext()
                rootResponse(strjson: str, id: PBID.loginPhone)
            }else {
                print("get protocol fail")
            }
            self.view.hideToastActivity()
        }

    }
    
    
    
    
}

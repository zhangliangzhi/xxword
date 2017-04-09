//
//  LoginViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/4/10.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    var outNumTextField:UITextField!
    var outPwdTextField:UITextField!
    var outLoginButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        self.view.addSubview(outNumTextField)
        
    }

}

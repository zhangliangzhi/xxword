//
//  ViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/4/1.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("h")
        let btn = UIButton(type: .contactAdd)
        self.view.addSubview(btn)
        btn.setTitle("Go", for: .normal)
        btn.frame = CGRect(x: 88, y: 88, width: 88, height: 88)
        btn.addTarget(self, action: #selector(btnGo), for: .touchUpInside)
//        btn.center = self.view.center
        
        
        let button:UIButton = UIButton(type: .system)
        //设置按钮位置和大小
        button.frame = CGRect(x:10, y:150, width:100, height:30)
        //设置按钮文字
        button.setTitle("按钮", for:.normal)
        self.view.addSubview(button)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func btnGo() {
//        self.present(LoginViewController(), animated: true) { 
//            print("hi")
//        }
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    
 
}


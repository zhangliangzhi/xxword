//
//  SxlxViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/4/24.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit

class SxlxViewController: UIViewController {

    var sv:UIScrollView!
    var v:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = BG1_COLOR
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(backHome))
        
        let indexPage:Int = Int((nowGlobalSet?.indexPage)!)
        var curIndex:Int32 = 0
        if (indexPage == 0) {
            curIndex = (nowGlobalSet?.curIndex0)!
        }else if(indexPage == 1) {
            curIndex = (nowGlobalSet?.curIndex1)!
        }else if(indexPage == 2) {
            curIndex = (nowGlobalSet?.curIndex2)!
        }else if(indexPage == 3) {
            curIndex = (nowGlobalSet?.curIndex3)!
        }else if(indexPage == 4) {
            curIndex = (nowGlobalSet?.curIndex4)!
        }else{
            
        }
//        self.navigationController?.navigationBar.barTintColor = UIColor.gray
        let id:Int = Int(curIndex)
        let ew =  cWord.getWord()[id]
        self.title = ew
        
        v = UIView()
        self.view.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.top.equalTo(self.view).offset(44)
            make.bottom.equalTo(self.view).offset(-49)
        }
        
        // 初始化界面
        initWordData(id: id)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    func initWordData(id:Int) {
        sv = UIScrollView()
        self.view.addSubview(sv)
        
        // 4个选项
        let v1 = UIButton(type: .system)
        v.addSubview(v1)
        v1.snp.makeConstraints { (make) in
            make.width.height.equalTo(v).multipliedBy(0.5)
            make.centerX.equalTo(v).multipliedBy(0.5)
            make.centerY.equalTo(v).multipliedBy(0.5)
        }
        v1.backgroundColor = BG2_COLOR
        v1.layer.borderWidth = 8
        v1.layer.borderColor = BG1_COLOR.cgColor
        v1.layer.cornerRadius = 30
        
        let v2 = UIButton(type: .system)
        v.addSubview(v2)
        v2.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(v1)
            make.left.equalTo(v1.snp.right).offset(0)
            make.right.equalTo(v)
        }
        v2.backgroundColor = BG2_COLOR
        v2.layer.borderWidth = 8
        v2.layer.borderColor = BG1_COLOR.cgColor
        v2.layer.cornerRadius = 30
        
        let v3 = UIButton(type: .system)
        v.addSubview(v3)
        v3.snp.makeConstraints { (make) in
            make.width.height.equalTo(v1)
            make.centerX.equalTo(v1)
            make.top.equalTo(v1.snp.bottom).offset(0)
        }
        v3.backgroundColor = BG2_COLOR
        v3.layer.borderWidth = 8
        v3.layer.borderColor = BG1_COLOR.cgColor
        v3.layer.cornerRadius = 30

        let v4 = UIButton(type: .system)
        v.addSubview(v4)
        v4.snp.makeConstraints { (make) in
            make.width.height.equalTo(v2)
            make.centerX.equalTo(v2)
            make.centerY.equalTo(v3)
        }
        v4.backgroundColor = BG2_COLOR
        v4.layer.borderWidth = 8
        v4.layer.borderColor = BG1_COLOR.cgColor
        v4.layer.cornerRadius = 30
    }
    
    func backHome() {
        appDelegate.window?.rootViewController?.removeFromParentViewController()
        appDelegate.window?.rootViewController = RootTabBarController()
    }
    
    func selButton(id:Int) -> Void {
        print(id)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

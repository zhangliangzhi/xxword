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
    var arrAdj:[Int] = []
    var arrAdv:[Int] = []
    var arrVt:[Int] = []
    var arrVi:[Int] = []
    var arrN:[Int] = []
    
    var arrOnePageAdj:[Int] = []
    var arrOnePageAdv:[Int] = []
    var arrOnePageVt:[Int] = []
    var arrOnePageVi:[Int] = []
    var arrOnePageN:[Int] = []
    
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
    
        arrAdj  = ocGetWordAdj() as! [Int]
        arrAdv  = ocGetWordAdv() as! [Int]
        arrVt   = ocGetWordVt() as! [Int]
        arrVi   = ocGetWordVi() as! [Int]
        arrN    = ocGetWordN() as! [Int]
        
        var total = 1000
        let page = Int((nowGlobalSet?.indexPage)!)
        if  page == 4 {
            total = 1004
        }
        let startID = page*1000
        let endID = startID + total
        // 单词分类 这个for循环好快
        for one in arrAdj {
            if one >= startID && one < endID {
                arrOnePageAdj.append(one)
            }
        }
        for one in arrAdv {
            if one >= startID && one < endID {
                arrOnePageAdv.append(one)
            }
        }
        for one in arrVt {
            if one >= startID && one < endID {
                arrOnePageVt.append(one)
            }
        }
        for one in arrVi {
            if one >= startID && one < endID {
                arrOnePageVi.append(one)
            }
        }
        for one in arrN {
            if one >= startID && one < endID {
                arrOnePageN.append(one)
            }
        }
        // 这个contains太慢了,5,6秒钟
//        for i in startID..<endID {
//            if arrAdj.contains(i) {
//                arrOnePageAdj.append(i)
//            }
//            if arrAdv.contains(i) {
//                arrOnePageAdv.append(i)
//            }
//            if arrVt.contains(i) {
//                arrOnePageVt.append(i)
//            }
//            if arrVi.contains(i) {
//                arrOnePageVi.append(i)
//            }
//            if arrN.contains(i) {
//                arrOnePageN.append(i)
//            }
//        }
        
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
        let adjtxt = "adj.    " + "\(arrOnePageAdj.count)" + "个单词"
        buttonAdj.setTitle(adjtxt, for: .normal)
        buttonAdj.addTarget(self, action: #selector(callbackAdj), for: .touchUpInside)
        
        // 2. adv
        let buttonAdv = BootstrapBtn(frame: CGRect.init(x: 0, y: 0, width: 50, height: 30), btButtonType: .Warning)
        rootv.addSubview(buttonAdv)
        buttonAdv.snp.makeConstraints { (make) in
            make.width.height.equalTo(buttonAdj)
            make.centerX.equalTo(buttonAdj)
            make.top.equalTo(buttonAdj.snp.bottom).offset(18)
        }
        let advtxt = "adv.    " + "\(arrOnePageAdv.count)" + "个单词"
        buttonAdv.setTitle(advtxt, for: .normal)
        buttonAdv.addTarget(self, action: #selector(callbackAdv), for: .touchUpInside)
        
        // 3. vt
        let buttonVt = BootstrapBtn(frame: CGRect.init(x: 0, y: 0, width: 50, height: 30), btButtonType: .Success)
        rootv.addSubview(buttonVt)
        buttonVt.snp.makeConstraints { (make) in
            make.width.height.equalTo(buttonAdj)
            make.centerX.equalTo(buttonAdj)
            make.top.equalTo(buttonAdv.snp.bottom).offset(18)
        }
        let vttxt = "vt.    " + "\(arrOnePageVt.count)" + "个单词"
        buttonVt.setTitle(vttxt, for: .normal)
        buttonVt.addTarget(self, action: #selector(callbackVt), for: .touchUpInside)
        
        // 4. vi
        let buttonVi = BootstrapBtn(frame: CGRect.init(x: 0, y: 0, width: 50, height: 30), btButtonType: .Success)
        rootv.addSubview(buttonVi)
        buttonVi.snp.makeConstraints { (make) in
            make.width.height.equalTo(buttonAdj)
            make.centerX.equalTo(buttonAdj)
            make.top.equalTo(buttonVt.snp.bottom).offset(18)
        }
        let vitxt = "vi.    " + "\(arrOnePageVi.count)" + "个单词"
        buttonVi.setTitle(vitxt, for: .normal)
        buttonVi.addTarget(self, action: #selector(callbackVi), for: .touchUpInside)
        
        
        // 5. n
        let buttonN = BootstrapBtn(frame: CGRect.init(x: 0, y: 0, width: 50, height: 30), btButtonType: .Info)
        rootv.addSubview(buttonN)
        buttonN.snp.makeConstraints { (make) in
            make.width.height.equalTo(buttonAdj)
            make.centerX.equalTo(buttonAdj)
            make.top.equalTo(buttonVi.snp.bottom).offset(18)
        }
        let ntxt = "n.    " + "\(arrOnePageN.count)" + "个单词"
        buttonN.setTitle(ntxt, for: .normal)
        buttonN.addTarget(self, action: #selector(callbackN), for: .touchUpInside)
    }
    
    func callbackAdj() {
        
        goStudyCustomWords(arrIds: arrOnePageAdj)
    }

    func callbackAdv() {
        
        goStudyCustomWords(arrIds: arrOnePageAdv)
    }
    
    func callbackVt() {
        
        goStudyCustomWords(arrIds: arrOnePageVt)
    }
    
    func callbackVi() {
        
        goStudyCustomWords(arrIds: arrOnePageVi)
    }
    
    func callbackN() {
        
        goStudyCustomWords(arrIds: arrOnePageN)
    }
    
    func goStudyCustomWords(arrIds:[Int]) {
        let tabbar = CustomTabBarController()
        tabbar.itype = 6
        tabbar.arrIds = arrIds
        tabbar.arrIds.sort(by: {$0<$1})
        tabbar.creatSubViewControllers()
        // 跳转到自定义 错题界面
        appDelegate.window?.rootViewController?.removeFromParentViewController()
        appDelegate.window?.rootViewController = tabbar
    }
}

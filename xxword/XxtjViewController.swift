//
//  XxtjViewController.swift
//  xxword
//  学习统计
//  Created by ZhangLiangZhi on 2017/5/17.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit

class XxtjViewController: UIViewController {

    var rootv: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BG1_COLOR
        self.title = "学习统计"
        
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
    
    func initUI() {
        var rightCount = 0
        var wrongCount = 0
        var nodoCount = 0
        var total = 1000
        let page = Int((nowGlobalSet?.indexPage)!)
        if  page == 4 {
            total = 1004
        }
        nodoCount = total - setDoneId.count
        wrongCount = setWrongID.count
        rightCount = total - nodoCount - wrongCount
        
        // 正确题数
        let lblRightTitle = UILabel()
        rootv.addSubview(lblRightTitle)
        lblRightTitle.snp.makeConstraints { (make) in
            make.top.equalTo(rootv).offset(28)
            make.centerX.equalTo(rootv).multipliedBy(0.5)
        }
        lblRightTitle.textAlignment = .right
        lblRightTitle.text = "正确单词数量"
        lblRightTitle.textColor = WZ1_COLOR
        lblRightTitle.font = UIFont.systemFont(ofSize: 16)
        
        // 错误单词数
        let lblWrongTitle = UILabel()
        rootv.addSubview(lblWrongTitle)
        lblWrongTitle.snp.makeConstraints { (make) in
            make.top.equalTo(lblRightTitle.snp.bottom).offset(10)
            make.centerX.equalTo(lblRightTitle)
        }
        lblWrongTitle.textAlignment = .right
        lblWrongTitle.text = "错误单词数量"
        lblWrongTitle.textColor = WZ1_COLOR
        lblWrongTitle.font = UIFont.systemFont(ofSize: 16)
        
        // 未做单词数量
        let lblUndoTitle = UILabel()
        rootv.addSubview(lblUndoTitle)
        lblUndoTitle.snp.makeConstraints { (make) in
            make.top.equalTo(lblWrongTitle.snp.bottom).offset(10)
            make.centerX.equalTo(lblRightTitle)
        }
        lblUndoTitle.textAlignment = .right
        lblUndoTitle.text = "未做单词数量"
        lblUndoTitle.textColor = WZ1_COLOR
        lblUndoTitle.font = UIFont.systemFont(ofSize: 16)
        
        // 正确数量
        let lblRightNum = UILabel()
        rootv.addSubview(lblRightNum)
        lblRightNum.snp.makeConstraints { (make) in
            make.centerX.equalTo(rootv)
            make.centerY.equalTo(lblRightTitle)
        }
        lblRightNum.textAlignment = .left
        lblRightNum.text = "\(rightCount)"
        lblRightNum.textColor = CG_COLOR
        lblRightNum.font = UIFont.systemFont(ofSize: 18)
        
        // 错误数量
        let lblWrongNum = UILabel()
        rootv.addSubview(lblWrongNum)
        lblWrongNum.snp.makeConstraints { (make) in
            make.centerX.equalTo(lblRightNum)
            make.centerY.equalTo(lblWrongTitle)
        }
        lblWrongNum.textAlignment = .left
        lblWrongNum.text = "\(wrongCount)"
        lblWrongNum.textColor = WARN_COLOR
        lblWrongNum.font = UIFont.systemFont(ofSize: 18)
        
        // 错误数量
        let lblUndoNum = UILabel()
        rootv.addSubview(lblUndoNum)
        lblUndoNum.snp.makeConstraints { (make) in
            make.centerX.equalTo(lblRightNum)
            make.centerY.equalTo(lblUndoTitle)
        }
        lblUndoNum.textAlignment = .left
        lblUndoNum.text = "\(nodoCount)"
        lblUndoNum.textColor = INFO_COLOR
        lblUndoNum.font = UIFont.systemFont(ofSize: 18)
        
        // 正确百分比
        let lblRightPer = UILabel()
        rootv.addSubview(lblRightPer)
        lblRightPer.snp.makeConstraints { (make) in
            make.centerX.equalTo(rootv).multipliedBy(1.5)
            make.centerY.equalTo(lblRightTitle)
        }
        lblRightPer.textAlignment = .left
        lblRightPer.text = "\(100 * rightCount / total)%"
        lblRightPer.textColor = WZ1_COLOR
        lblRightPer.font = UIFont.systemFont(ofSize: 18)
        
        // 错误百分比
        let lblWrongPer = UILabel()
        rootv.addSubview(lblWrongPer)
        lblWrongPer.snp.makeConstraints { (make) in
            make.centerX.equalTo(lblRightPer)
            make.centerY.equalTo(lblWrongTitle)
        }
        lblWrongPer.textAlignment = .left
        lblWrongPer.text = "\(100 * wrongCount / total)%"
        lblWrongPer.textColor = WZ1_COLOR
        lblWrongPer.font = UIFont.systemFont(ofSize: 18)
        
        // 未做百分比
        let lblUndoPer = UILabel()
        rootv.addSubview(lblUndoPer)
        lblUndoPer.snp.makeConstraints { (make) in
            make.centerX.equalTo(lblRightPer)
            make.centerY.equalTo(lblUndoTitle)
        }
        lblUndoPer.textAlignment = .left
        lblUndoPer.text = "\(100 * nodoCount / total)%"
        lblUndoPer.textColor = WZ1_COLOR
        lblUndoPer.font = UIFont.systemFont(ofSize: 18)
        
        let btnGo = BootstrapBtn(frame: CGRect(x: 0, y: 0, width: 50, height: 30), btButtonType: .Success)
        rootv.addSubview(btnGo)
        btnGo.snp.makeConstraints { (make) in
            make.width.equalTo(rootv).multipliedBy(0.618)
            make.height.equalTo(38)
            make.centerX.equalTo(rootv)
            make.top.equalTo(lblUndoTitle.snp.bottom).offset(28)
        }
        btnGo.setTitle("去学习", for: .normal)
        btnGo.addTarget(self, action: #selector(callbackGoStudy), for: .touchUpInside)
    }

    func callbackGoStudy() {
        // 太聪明了，赞
        appDelegate.window?.rootViewController?.removeFromParentViewController()
        appDelegate.window?.rootViewController = StudyTabBarController()
        
    }
}

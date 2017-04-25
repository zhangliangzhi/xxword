//
//  HomeViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/4/22.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    var v:UIView!
    var labelWrongNum:UILabel!
    var labelFavorNum:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // root view
        v = UIView()
        self.view.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.width.height.equalTo(self.view)
        }
        
        // background
        self.view.backgroundColor = BG1_COLOR
        // init something
        initHomeView() 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func initHomeView() {
        
        
        // 顺序练习
        addNormalBtn()
        
    }
    
    func addNormalBtn() {
        // 顺序学习按钮
        let btnNormalStudy = UIButton(type: .system)
        v.addSubview(btnNormalStudy)
        btnNormalStudy.snp.makeConstraints { (make) in
            make.width.equalTo(v.snp.width).multipliedBy(0.33)
            make.height.equalTo(v.snp.width).multipliedBy(0.415)
            make.left.equalTo(v)
            make.top.equalTo(v).offset(64)
        }
        btnNormalStudy.backgroundColor = BG2_COLOR
        btnNormalStudy.addTarget(self, action: #selector(callbackNormalStudy), for: .touchUpInside)
        let imgNormalStudy = UIImageView(image: UIImage(named: "sxlx"))
        btnNormalStudy.addSubview(imgNormalStudy)
        imgNormalStudy.snp.makeConstraints { (make) in
            make.centerX.equalTo(btnNormalStudy)
            make.centerY.equalTo(btnNormalStudy).offset(-10)
            make.width.equalTo(btnNormalStudy.snp.width).multipliedBy(0.4)
            make.height.equalTo(btnNormalStudy.snp.width).multipliedBy(0.6)
        }
        let lblNormalStudy = UILabel()
        btnNormalStudy.addSubview(lblNormalStudy)
        lblNormalStudy.snp.makeConstraints { (make) in
            make.top.equalTo(imgNormalStudy.snp.bottom).offset(8)
            make.centerX.equalTo(btnNormalStudy)
            make.width.equalTo(btnNormalStudy)
            make.height.equalTo(20)
        }
        lblNormalStudy.textAlignment = .center
        lblNormalStudy.text = "顺序学习"
        lblNormalStudy.textColor = WZ1_COLOR
        lblNormalStudy.font = UIFont.systemFont(ofSize: 20)
        
        // 模拟考试
        let btnMnks = UIButton(type: .system)
        v.addSubview(btnMnks)
        btnMnks.snp.makeConstraints { (make) in
            make.width.height.equalTo(btnNormalStudy)
            make.left.equalTo(btnNormalStudy)
            make.top.equalTo(btnNormalStudy.snp.bottom).offset(10)
        }
        btnMnks.backgroundColor = BG2_COLOR
        btnMnks.addTarget(self, action: #selector(callbackMnks), for: .touchUpInside)
        let imgMnks = UIImageView(image: UIImage(named: "mnks"))
        btnMnks.addSubview(imgMnks)
        imgMnks.snp.makeConstraints { (make) in
            make.centerX.equalTo(btnMnks)
            make.centerY.equalTo(btnMnks).offset(-10)
            make.width.equalTo(btnMnks.snp.width).multipliedBy(0.4)
            make.height.equalTo(btnMnks.snp.width).multipliedBy(0.6)
        }
        let lblMnks = UILabel()
        btnMnks.addSubview(lblMnks)
        lblMnks.snp.makeConstraints { (make) in
            make.top.equalTo(imgMnks.snp.bottom).offset(8)
            make.centerX.equalTo(btnMnks)
            make.width.equalTo(btnMnks)
            make.height.equalTo(20)
        }
        lblMnks.textAlignment = .center
        lblMnks.text = "模拟考试"
        lblMnks.textColor = WZ1_COLOR
        lblMnks.font = UIFont.systemFont(ofSize: 20)
        
        // 随机练习按钮
        let btnSjlx = UIButton(type: .system)
        v.addSubview(btnSjlx)
        btnSjlx.snp.makeConstraints { (make) in
            make.top.equalTo(btnNormalStudy)
            make.left.equalTo(btnNormalStudy.snp.right).offset(3)
            make.width.equalTo(btnNormalStudy)
            make.height.equalTo(btnNormalStudy.snp.height).multipliedBy(0.5)
        }
        btnSjlx.backgroundColor = BG2_COLOR
        btnSjlx.addTarget(self, action: #selector(callbackSjlx), for: .touchUpInside)
        let imgSjlx = UIImageView(image: UIImage(named: "sjlx"))
        btnSjlx.addSubview(imgSjlx)
        imgSjlx.snp.makeConstraints { (make) in
            make.centerX.equalTo(btnSjlx)
            make.centerY.equalTo(btnSjlx).offset(-10)
            make.width.height.equalTo(btnSjlx.snp.width).multipliedBy(0.3)
        }
        let lblSjlx = UILabel()
        btnSjlx.addSubview(lblSjlx)
        lblSjlx.snp.makeConstraints { (make) in
            make.top.equalTo(imgSjlx.snp.bottom).offset(3)
            make.centerX.equalTo(btnSjlx)
            make.width.equalTo(btnSjlx)
            make.height.equalTo(20)
        }
        lblSjlx.textAlignment = .center
        lblSjlx.text = "随机练习"
        lblSjlx.textColor = WZ1_COLOR
        lblSjlx.font = UIFont.systemFont(ofSize: 18)
        
        // 专项练习按钮
        let btnZxlx = UIButton(type: .system)
        v.addSubview(btnZxlx)
        btnZxlx.snp.makeConstraints { (make) in
            make.top.equalTo(btnNormalStudy)
            make.left.equalTo(btnSjlx.snp.right).offset(2)
            make.width.equalTo(btnNormalStudy)
            make.height.equalTo(btnNormalStudy.snp.height).multipliedBy(0.5)
        }
        btnZxlx.backgroundColor = BG2_COLOR
        btnZxlx.addTarget(self, action: #selector(callbackZxlx), for: .touchUpInside)
        let imgZxlx = UIImageView(image: UIImage(named: "zxlx"))
        btnZxlx.addSubview(imgZxlx)
        imgZxlx.snp.makeConstraints { (make) in
            make.centerX.equalTo(btnZxlx)
            make.centerY.equalTo(btnZxlx).offset(-10)
            make.width.height.equalTo(btnZxlx.snp.width).multipliedBy(0.3)
        }
        let lblZxlx = UILabel()
        btnZxlx.addSubview(lblZxlx)
        lblZxlx.snp.makeConstraints { (make) in
            make.top.equalTo(imgZxlx.snp.bottom).offset(3)
            make.centerX.equalTo(btnZxlx)
            make.width.equalTo(btnZxlx)
            make.height.equalTo(20)
        }
        lblZxlx.textAlignment = .center
        lblZxlx.text = "专项练习"
        lblZxlx.textColor = WZ1_COLOR
        lblZxlx.font = UIFont.systemFont(ofSize: 18)
        
        // 未做题按钮
        let btnWzt = UIButton(type: .system)
        v.addSubview(btnWzt)
        btnWzt.snp.makeConstraints { (make) in
            make.bottom.equalTo(btnNormalStudy)
            make.left.equalTo(btnNormalStudy.snp.right).offset(3)
            make.width.equalTo(btnNormalStudy)
            make.height.equalTo(btnNormalStudy.snp.height).multipliedBy(0.49)
        }
        btnWzt.backgroundColor = BG2_COLOR
        btnWzt.addTarget(self, action: #selector(callbackWzt), for: .touchUpInside)
        let imgWzt = UIImageView(image: UIImage(named: "wzt"))
        btnWzt.addSubview(imgWzt)
        imgWzt.snp.makeConstraints { (make) in
            make.centerX.equalTo(btnWzt)
            make.centerY.equalTo(btnWzt).offset(-10)
            make.width.height.equalTo(btnWzt.snp.width).multipliedBy(0.3)
        }
        let lblWzt = UILabel()
        btnWzt.addSubview(lblWzt)
        lblWzt.snp.makeConstraints { (make) in
            make.top.equalTo(imgWzt.snp.bottom).offset(3)
            make.centerX.equalTo(btnWzt)
            make.width.equalTo(btnWzt)
            make.height.equalTo(20)
        }
        lblWzt.textAlignment = .center
        lblWzt.text = "未做题"
        lblWzt.textColor = WZ1_COLOR
        lblWzt.font = UIFont.systemFont(ofSize: 18)
        
        // 精选难题按钮
        let btnJxnt = UIButton(type: .system)
        v.addSubview(btnJxnt)
        btnJxnt.snp.makeConstraints { (make) in
            make.bottom.equalTo(btnNormalStudy)
            make.left.equalTo(btnWzt.snp.right).offset(2)
            make.width.equalTo(btnNormalStudy)
            make.height.equalTo(btnNormalStudy.snp.height).multipliedBy(0.49)
        }
        btnJxnt.backgroundColor = BG2_COLOR
        btnJxnt.addTarget(self, action: #selector(callbackJxnt), for: .touchUpInside)
        let imgJxnt = UIImageView(image: UIImage(named: "jxnt"))
        btnJxnt.addSubview(imgJxnt)
        imgJxnt.snp.makeConstraints { (make) in
            make.centerX.equalTo(btnJxnt)
            make.centerY.equalTo(btnJxnt).offset(-10)
            make.width.height.equalTo(btnJxnt.snp.width).multipliedBy(0.3)
        }
        let lblJxnt = UILabel()
        btnJxnt.addSubview(lblJxnt)
        lblJxnt.snp.makeConstraints { (make) in
            make.top.equalTo(imgJxnt.snp.bottom).offset(3)
            make.centerX.equalTo(btnJxnt)
            make.width.equalTo(btnJxnt)
            make.height.equalTo(20)
        }
        lblJxnt.textAlignment = .center
        lblJxnt.text = "精选难题"
        lblJxnt.textColor = WZ1_COLOR
        lblJxnt.font = UIFont.systemFont(ofSize: 18)
        
        // 考试记录按钮
        let btnKsjl = UIButton(type: .system)
        v.addSubview(btnKsjl)
        btnKsjl.snp.makeConstraints { (make) in
            make.top.equalTo(btnMnks)
            make.left.equalTo(btnMnks.snp.right).offset(3)
            make.width.equalTo(btnNormalStudy)
            make.height.equalTo(btnNormalStudy.snp.height).multipliedBy(0.5)
        }
        btnKsjl.backgroundColor = BG2_COLOR
        btnKsjl.addTarget(self, action: #selector(callbackKsjl), for: .touchUpInside)
        let imgKsjl = UIImageView(image: UIImage(named: "ksjl"))
        btnKsjl.addSubview(imgKsjl)
        imgKsjl.snp.makeConstraints { (make) in
            make.centerX.equalTo(btnKsjl)
            make.centerY.equalTo(btnKsjl).offset(-10)
            make.width.height.equalTo(btnKsjl.snp.width).multipliedBy(0.3)
        }
        let lblKsjl = UILabel()
        btnKsjl.addSubview(lblKsjl)
        lblKsjl.snp.makeConstraints { (make) in
            make.top.equalTo(imgKsjl.snp.bottom).offset(3)
            make.centerX.equalTo(btnKsjl)
            make.width.equalTo(btnKsjl)
            make.height.equalTo(20)
        }
        lblKsjl.textAlignment = .center
        lblKsjl.text = "考试记录"
        lblKsjl.textColor = WZ1_COLOR
        lblKsjl.font = UIFont.systemFont(ofSize: 18)
        
        // 成绩排行按钮
        let btnCjph = UIButton(type: .system)
        v.addSubview(btnCjph)
        btnCjph.snp.makeConstraints { (make) in
            make.top.equalTo(btnMnks)
            make.left.equalTo(btnKsjl.snp.right).offset(2)
            make.width.equalTo(btnNormalStudy)
            make.height.equalTo(btnNormalStudy.snp.height).multipliedBy(0.5)
        }
        btnCjph.backgroundColor = BG2_COLOR
        btnCjph.addTarget(self, action: #selector(callbackCjph), for: .touchUpInside)
        let imgCjph = UIImageView(image: UIImage(named: "cjph"))
        btnCjph.addSubview(imgCjph)
        imgCjph.snp.makeConstraints { (make) in
            make.centerX.equalTo(btnCjph)
            make.centerY.equalTo(btnCjph).offset(-10)
            make.width.height.equalTo(btnCjph.snp.width).multipliedBy(0.3)
        }
        let lblCjph = UILabel()
        btnCjph.addSubview(lblCjph)
        lblCjph.snp.makeConstraints { (make) in
            make.top.equalTo(imgCjph.snp.bottom).offset(3)
            make.centerX.equalTo(btnCjph)
            make.width.equalTo(btnCjph)
            make.height.equalTo(20)
        }
        lblCjph.textAlignment = .center
        lblCjph.text = "成绩排行"
        lblCjph.textColor = WZ1_COLOR
        lblCjph.font = UIFont.systemFont(ofSize: 18)
        
        // 考试须知按钮
        let btnKsxz = UIButton(type: .system)
        v.addSubview(btnKsxz)
        btnKsxz.snp.makeConstraints { (make) in
            make.bottom.equalTo(btnMnks)
            make.left.equalTo(btnMnks.snp.right).offset(3)
            make.width.equalTo(btnNormalStudy)
            make.height.equalTo(btnNormalStudy.snp.height).multipliedBy(0.49)
        }
        btnKsxz.backgroundColor = BG2_COLOR
        btnKsxz.addTarget(self, action: #selector(callbackKsxz), for: .touchUpInside)
        let imgKsxz = UIImageView(image: UIImage(named: "ksxz"))
        btnKsxz.addSubview(imgKsxz)
        imgKsxz.snp.makeConstraints { (make) in
            make.centerX.equalTo(btnKsxz)
            make.centerY.equalTo(btnKsxz).offset(-10)
            make.width.height.equalTo(btnKsxz.snp.width).multipliedBy(0.3)
        }
        let lblKsxz = UILabel()
        btnKsxz.addSubview(lblKsxz)
        lblKsxz.snp.makeConstraints { (make) in
            make.top.equalTo(imgKsxz.snp.bottom).offset(3)
            make.centerX.equalTo(btnKsxz)
            make.width.equalTo(btnKsxz)
            make.height.equalTo(20)
        }
        lblKsxz.textAlignment = .center
        lblKsxz.text = "考试须知"
        lblKsxz.textColor = WZ1_COLOR
        lblKsxz.font = UIFont.systemFont(ofSize: 18)
        
        // 摇一摇按钮
        let btnYyy = UIButton(type: .system)
        v.addSubview(btnYyy)
        btnYyy.snp.makeConstraints { (make) in
            make.bottom.equalTo(btnMnks)
            make.left.equalTo(btnKsxz.snp.right).offset(2)
            make.width.equalTo(btnNormalStudy)
            make.height.equalTo(btnNormalStudy.snp.height).multipliedBy(0.49)
        }
        btnYyy.backgroundColor = BG2_COLOR
        btnYyy.addTarget(self, action: #selector(callbackYyy), for: .touchUpInside)
        let imgYyy = UIImageView(image: UIImage(named: "yyy"))
        btnYyy.addSubview(imgYyy)
        imgYyy.snp.makeConstraints { (make) in
            make.centerX.equalTo(btnYyy)
            make.centerY.equalTo(btnYyy).offset(-10)
            make.width.height.equalTo(btnYyy.snp.width).multipliedBy(0.3)
        }
        let lblYyy = UILabel()
        btnYyy.addSubview(lblYyy)
        lblYyy.snp.makeConstraints { (make) in
            make.top.equalTo(imgYyy.snp.bottom).offset(3)
            make.centerX.equalTo(btnYyy)
            make.width.equalTo(btnYyy)
            make.height.equalTo(20)
        }
        lblYyy.textAlignment = .center
        lblYyy.text = "摇一摇"
        lblYyy.textColor = WZ1_COLOR
        lblYyy.font = UIFont.systemFont(ofSize: 18)
        
        // 4个按钮
        // 我的错题
        let btnWdct = UIButton(type: .system)
        v.addSubview(btnWdct)
        btnWdct.snp.makeConstraints { (make) in
            make.width.equalTo(v).multipliedBy(0.25)
            make.height.equalTo(btnKsjl)
            make.left.equalTo(v)
            make.top.equalTo(btnMnks.snp.bottom).offset(10)
        }
        btnWdct.backgroundColor = BG2_COLOR
        btnWdct.addTarget(self, action: #selector(callbackWdct), for: .touchUpInside)
        let imgWdct = UIImageView(image: UIImage(named: "iwdct"))
        btnWdct.addSubview(imgWdct)
        imgWdct.snp.makeConstraints { (make) in
            make.centerX.equalTo(btnWdct)
            make.centerY.equalTo(btnWdct).offset(-15)
            make.width.equalTo(btnWdct.snp.width).multipliedBy(0.3)
            make.height.equalTo(btnWdct.snp.width).multipliedBy(0.3)
        }
        let lblWdct = UILabel()
        btnWdct.addSubview(lblWdct)
        lblWdct.snp.makeConstraints { (make) in
            make.top.equalTo(imgWdct.snp.bottom).offset(3)
            make.centerX.equalTo(btnWdct)
            make.width.equalTo(btnWdct)
            make.height.equalTo(20)
        }
        lblWdct.textAlignment = .center
        lblWdct.text = "我的错题"
        lblWdct.textColor = WZ1_COLOR
        // 错题数量
        labelWrongNum = UILabel()
        btnWdct.addSubview(labelWrongNum)
        labelWrongNum.snp.makeConstraints { (make) in
            make.bottom.equalTo(btnWdct).offset(-3)
            make.centerX.equalTo(btnWdct)
            make.width.equalTo(btnWdct)
            make.height.equalTo(20)
        }
        labelWrongNum.textAlignment = .center
        labelWrongNum.text = "0"
        labelWrongNum.textColor = WZ2_COLOR
        labelWrongNum.font = UIFont.systemFont(ofSize: 16)
        
        
        // 我的收藏
        let btnWdsc = UIButton(type: .system)
        v.addSubview(btnWdsc)
        btnWdsc.snp.makeConstraints { (make) in
            make.width.height.equalTo(btnWdct)
            make.left.equalTo(btnWdct.snp.right)
            make.top.equalTo(btnWdct)
        }
        btnWdsc.backgroundColor = BG2_COLOR
        btnWdsc.addTarget(self, action: #selector(callbackWdsc), for: .touchUpInside)
        let imgWdsc = UIImageView(image: UIImage(named: "iwdsc"))
        btnWdsc.addSubview(imgWdsc)
        imgWdsc.snp.makeConstraints { (make) in
            make.centerX.equalTo(btnWdsc)
            make.centerY.equalTo(btnWdsc).offset(-15)
            make.width.equalTo(btnWdsc.snp.width).multipliedBy(0.3)
            make.height.equalTo(btnWdsc.snp.width).multipliedBy(0.3)
        }
        let lblWdsc = UILabel()
        btnWdsc.addSubview(lblWdsc)
        lblWdsc.snp.makeConstraints { (make) in
            make.top.equalTo(imgWdsc.snp.bottom).offset(3)
            make.centerX.equalTo(btnWdsc)
            make.width.equalTo(btnWdsc)
            make.height.equalTo(20)
        }
        lblWdsc.textAlignment = .center
        lblWdsc.text = "我的收藏"
        lblWdsc.textColor = WZ1_COLOR
        // 收藏数量
        labelFavorNum = UILabel()
        btnWdsc.addSubview(labelFavorNum)
        labelFavorNum.snp.makeConstraints { (make) in
            make.bottom.equalTo(btnWdsc).offset(-3)
            make.centerX.equalTo(btnWdsc)
            make.width.equalTo(btnWdsc)
            make.height.equalTo(20)
        }
        labelFavorNum.textAlignment = .center
        labelFavorNum.text = "0"
        labelFavorNum.textColor = WZ2_COLOR
        labelFavorNum.font = UIFont.systemFont(ofSize: 16)
        
        // 学习统计
        let btnXxtj = UIButton(type: .system)
        v.addSubview(btnXxtj)
        btnXxtj.snp.makeConstraints { (make) in
            make.width.height.equalTo(btnWdct)
            make.left.equalTo(btnWdsc.snp.right)
            make.top.equalTo(btnWdct)
        }
        btnXxtj.backgroundColor = BG2_COLOR
        btnXxtj.addTarget(self, action: #selector(callbackXxtj), for: .touchUpInside)
        let imgXxtj = UIImageView(image: UIImage(named: "ixxtj"))
        btnXxtj.addSubview(imgXxtj)
        imgXxtj.snp.makeConstraints { (make) in
            make.centerX.equalTo(btnXxtj)
            make.centerY.equalTo(btnXxtj).offset(-15)
            make.width.equalTo(btnXxtj.snp.width).multipliedBy(0.3)
            make.height.equalTo(btnXxtj.snp.width).multipliedBy(0.3)
        }
        let lblXxtj = UILabel()
        btnXxtj.addSubview(lblXxtj)
        lblXxtj.snp.makeConstraints { (make) in
            make.top.equalTo(imgXxtj.snp.bottom).offset(5)
            make.centerX.equalTo(btnXxtj)
            make.width.equalTo(btnXxtj)
            make.height.equalTo(20)
        }
        lblXxtj.textAlignment = .center
        lblXxtj.text = "学习统计"
        lblXxtj.textColor = WZ1_COLOR
        
        // 交通标志
        let btnJtbz = UIButton(type: .system)
        v.addSubview(btnJtbz)
        btnJtbz.snp.makeConstraints { (make) in
            make.width.height.equalTo(btnWdct)
            make.left.equalTo(btnXxtj.snp.right)
            make.top.equalTo(btnWdct)
        }
        btnJtbz.backgroundColor = BG2_COLOR
        btnJtbz.addTarget(self, action: #selector(callbackJtbz), for: .touchUpInside)
        let imgJtbz = UIImageView(image: UIImage(named: "ijtbz"))
        btnJtbz.addSubview(imgJtbz)
        imgJtbz.snp.makeConstraints { (make) in
            make.centerX.equalTo(btnJtbz)
            make.centerY.equalTo(btnJtbz).offset(-15)
            make.width.equalTo(btnJtbz.snp.width).multipliedBy(0.3)
            make.height.equalTo(btnJtbz.snp.width).multipliedBy(0.3)
        }
        let lblJtbz = UILabel()
        btnJtbz.addSubview(lblJtbz)
        lblJtbz.snp.makeConstraints { (make) in
            make.top.equalTo(imgJtbz.snp.bottom).offset(5)
            make.centerX.equalTo(btnJtbz)
            make.width.equalTo(btnJtbz)
            make.height.equalTo(20)
        }
        lblJtbz.textAlignment = .center
        lblJtbz.text = "交通标志"
        lblJtbz.textColor = WZ1_COLOR
    }
    
    // 点击 顺序学习
    func callbackNormalStudy() -> Void {
        print("normal Study")
    }
    // 点击 顺序学习
    func callbackMnks() -> Void {
        print("mnks Study")
    }
    // 点击 随机练习
    func callbackSjlx() -> Void {
        print("sjlx Study")
    }
    // 点击 专项练习
    func callbackZxlx() -> Void {
        print("zxlx Study")
    }
    // 点击 为做题
    func callbackWzt() -> Void {
        print("Wzt Study")
    }
    // 点击 精选难题
    func callbackJxnt() -> Void {
        print("Jxnt Study")
    }
    // 点击 考试记录
    func callbackKsjl() -> Void {
        print("ksjl Study")
    }
    // 点击 成绩排行
    func callbackCjph() -> Void {
        print("cjph Study")
    }
    // 点击 考试须知
    func callbackKsxz() -> Void {
        print("ksxz Study")
    }
    // 点击 摇一摇
    func callbackYyy() -> Void {
        print("yyy Study")
    }
    
    // 点击 我的错题
    func callbackWdct() -> Void {
        print("wdct Study")
    }
    // 点击 我的收藏
    func callbackWdsc() -> Void {
        print("wdsc Study")
    }
    // 点击 学习统计
    func callbackXxtj() -> Void {
        print("xxtj Study")
    }
    // 点击 交通标志
    func callbackJtbz() -> Void {
        print("jtbz Study")
    }
    
}
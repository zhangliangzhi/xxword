//
//  HomeViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/4/22.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit
import SnapKit
import CoreData
import Alamofire

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext
var arrGlobalSet:[CurGlobalSet] = []
var arrStudyWord:[StudyWord] = []
var arrMyErrorID:[MyErrorID] = []
var arrMyFavorID:[MyFavorID] = []
var arrExamList:[ExamList] = []
var setFavorID = Set<Int>()
var setWrongID = Set<Int>()
var setDoneId = Set<Int>()
var nowGlobalSet:CurGlobalSet?
let rootUrl = "https://xx5000.duapp.com/xx/"
var gClickIndex:Int32 = 0 // 临时点击的值,没编号itype的

let gWord = ocGetWord() as! [String]
let gDetail = ocGetDetail() as! [[String]]
let gKey = ocGetKey() as! [String]

class HomeViewController: UIViewController {

    var v:UIScrollView!
    var labelWrongNum:UILabel!
    var labelFavorNum:UILabel!
    var svh:CGFloat = 1.1
    var segment:UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "象形单词"
        self.automaticallyAdjustsScrollViewInsets = false
        // root view
        v = UIScrollView()
        self.view.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(64+30)
            make.bottom.equalTo(self.view).offset(-44)
            make.width.equalTo(self.view)
            make.centerX.equalTo(self.view)
        }
        svh = 0.415 + 0.415 + (0.415 * 0.5 * 1.2)
        
        v.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.width * svh + 50 + 30)
        

        // init something
        HomeViewController.getCoreData()
        firstOpenAPP()
        initHomeView()
        
        // background
        self.view.backgroundColor = BG1_COLOR
        // 检测设备方向
        NotificationCenter.default.addObserver(self, selector: #selector(receivedRotation), name: .UIDeviceOrientationDidChange, object: nil)
    }

    //通知监听触发的方法
    func receivedRotation(){
        if UIDevice.current.orientation.isPortrait {
        }
        v.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.width * svh + 50 + 30)
        
        // 横竖的时候顶部按钮的变化
        segment.snp.updateConstraints { (make) in
            if UIDevice.current.orientation.isLandscape {
                make.top.equalTo(self.view).offset(44)
            }else {
                make.top.equalTo(self.view).offset(64)
            }
        }
        v.snp.updateConstraints { (make) in
            if UIDevice.current.orientation.isLandscape {
                make.top.equalTo(self.view).offset(44+30)
            }else {
                make.top.equalTo(self.view).offset(64+30)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        HomeViewController.getCoreData()
        firstOpenAPP()
        loginNow()
        jchy()
        changeTexValue()
//        print(nowGlobalSet?.phone, nowGlobalSet?.pwd, nowGlobalSet?.token)
        
    }
    
    func initHomeView() {
        
        // 顺序练习
        addNormalBtn()
        
        // 文本按数据显示正确
        changeTexValue()
    }
    
    func addNormalBtn() {
        // segment 按钮
        let sitems = ["1-1000", "1k-2k", "2k-3k", "3k-4k", "4k-5004"]
        segment = UISegmentedControl(items: sitems)
        self.view.addSubview(segment)
        segment.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(64)
            make.width.equalTo(self.view)
            make.height.equalTo(30)
        }
//        segment.tintColor = WZ1_COLOR
        //默认选中
        segment.selectedSegmentIndex = Int((nowGlobalSet?.indexPage)!)
        //添加值改变监听
        segment.addTarget(self, action: #selector(segmentDidchange(_:)), for: .valueChanged)
        
        // 顺序学习按钮
        let btnNormalStudy = UIButton(type: .system)
        v.addSubview(btnNormalStudy)
        btnNormalStudy.snp.makeConstraints { (make) in
            make.width.equalTo(v.snp.width).multipliedBy(0.33)
            make.height.equalTo(v.snp.width).multipliedBy(0.415)
            make.left.equalTo(v)
            make.top.equalTo(v.snp.top).offset(6)
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
        lblMnks.text = "单词考试"
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
        lblJxnt.text = "精选难词"
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
        lblKsxz.text = "考试说明"
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
            make.height.equalTo(btnKsjl).multipliedBy(1.2)
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
        let imgJtbz = UIImageView(image: UIImage(named: "wrong_list"))
        btnJtbz.addSubview(imgJtbz)
        imgJtbz.snp.makeConstraints { (make) in
            make.centerX.equalTo(btnJtbz)
            make.centerY.equalTo(btnJtbz).offset(-15)
            make.width.equalTo(btnJtbz.snp.width).multipliedBy(0.35)
            make.height.equalTo(btnJtbz.snp.width).multipliedBy(0.35)
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
        lblJtbz.text = "错词一览"
        lblJtbz.textColor = WZ1_COLOR
        
        // 去学习按钮
        let outGoXxButton = BootstrapBtn(frame: CGRect(x: 0, y: 0, width: 150, height: 40), btButtonType: .Success)
        v.addSubview(outGoXxButton)
        outGoXxButton.snp.makeConstraints { (make) in
            make.width.equalTo(v).multipliedBy(0.618)
            make.height.equalTo(40)
            make.centerX.equalTo(v)
            make.top.equalTo(btnJtbz.snp.bottom).offset(8)
        }
        outGoXxButton.setTitle("❤️爱上玩单词👻", for: .normal)
        outGoXxButton.addTarget(self, action: #selector(callbackNormalStudy), for: .touchUpInside)
        
    }
    
    // 第几排单词 1k,2k,3k,4k,5k
    func segmentDidchange(_ segmented:UISegmentedControl){
        //获得选项的索引
//        print(segmented.selectedSegmentIndex)
        //获得选择的文字
//        print(segmented.titleForSegment(at: segmented.selectedSegmentIndex))
        
        nowGlobalSet?.indexPage = Int32(segmented.selectedSegmentIndex)
        appDelegate.saveContext()
        
        // 改变文本标签
        changeTexValue()
    }
    
    func changeTexValue() {
        // 更新最新数据
        setWrongID.removeAll()
        setDoneId.removeAll()
        for one in arrMyErrorID {
            let wid:Int = Int(one.wid)
            setDoneId.insert(wid)
            if (one.indexPage == nowGlobalSet?.indexPage) && one.isRight == false {
                setWrongID.insert(wid)
            }
        }
        setFavorID.removeAll()
        for one in arrMyFavorID {
            if (one.indexPage == nowGlobalSet?.indexPage)  {
                setFavorID.insert(Int(one.wid))
            }
        }
        
        // 做了多少题目, 我的错题目
        let errCount = setWrongID.count
        // 我的收藏
        let favorCount = setFavorID.count
        
        labelWrongNum.text = "\(errCount)"
        labelFavorNum.text = "\(favorCount)"
    }
    
    static func getCoreData() -> Void {
        arrStudyWord = []
        arrGlobalSet = []
        arrMyErrorID = []
        arrMyFavorID = []
        arrExamList = []
        
        arrMyFavorID.removeAll()
        do {
            arrStudyWord = try context.fetch(StudyWord.fetchRequest())
        }catch {
            print("StudyWord coreData error")
        }
        
        do {
            arrGlobalSet = try context.fetch(CurGlobalSet.fetchRequest())
        }catch {
            print("Setting coreData error")
        }
        
        do {
            arrMyErrorID = try context.fetch(MyErrorID.fetchRequest())
        }catch {
            print("MyErrorID coreData error")
        }
        
        do {
            arrMyFavorID = try context.fetch(MyFavorID.fetchRequest())
        }catch {
            print("MyFavorID coreData error")
        }
        
        do {
            arrExamList = try context.fetch(ExamList.fetchRequest())
        }catch {
            print("ExamList coreData error")
        }
        
        if arrGlobalSet.count > 0 {
            nowGlobalSet = arrGlobalSet[0]
        }
        
        //        print(nowGlobalSet)
    }
    
    func jchy() {
        let isVip:Bool = (nowGlobalSet?.isVIP)!
        if isVip == false {
            return
        }
        let vipdate = nowGlobalSet?.vipDate
        if vipdate == nil {
            nowGlobalSet?.isVIP = false
            appDelegate.saveContext()
            return
        }
        let sjc:Int64 = Int64((vipdate?.timeIntervalSince1970)!)
        if sjc != nowGlobalSet?.vipsjc {
            nowGlobalSet?.isVIP = false
            appDelegate.saveContext()
            return
        }
        // 是否在31天以内
        let nowsjc:Int64 = Int64(Date().timeIntervalSince1970)
        let endSecond:Int64 = sjc + 31*24*3600
        if nowsjc > endSecond || nowsjc<=sjc-86400 {
            nowGlobalSet?.isVIP = false
            appDelegate.saveContext()
            return
        }
    }
    
    static func goStudyingUI() {
        // 跳转到第一个界面
        appDelegate.window?.rootViewController?.removeFromParentViewController()
        appDelegate.window?.rootViewController = StudyTabBarController()
    }
    
    // 第一次打开app，加入测试数据
    func firstOpenAPP() -> Void {
        // 初始化
        if arrGlobalSet.count > 0 {
            return
        }
        
        let oneGlobalSet = NSEntityDescription.insertNewObject(forEntityName: "CurGlobalSet", into: context) as! CurGlobalSet
        
        oneGlobalSet.coin = 0
        oneGlobalSet.diamond = 0
        oneGlobalSet.exp = 0
        oneGlobalSet.phone = ""
        oneGlobalSet.pwd = ""
        oneGlobalSet.token = ""
        oneGlobalSet.vipsjc = 0
        oneGlobalSet.uid = ""
        oneGlobalSet.ismusic = true     // 播放单词声音
        oneGlobalSet.iskipword = true   // 正确自动跳转
        oneGlobalSet.isShowwrCount = true // 是否显示正确错误次数
        oneGlobalSet.indexPage = 0
        oneGlobalSet.indexType = 0  // 0--5k, 1--9k
        // 顺序练习 开始id
        oneGlobalSet.curIndex0 = 0
        oneGlobalSet.curIndex1 = 1000
        oneGlobalSet.curIndex2 = 2000
        oneGlobalSet.curIndex3 = 3000
        oneGlobalSet.curIndex4 = 4000
        oneGlobalSet.curIndex11 = 0 // 象形9000
        oneGlobalSet.curIndex12 = 0
        oneGlobalSet.curIndex13 = 0
        oneGlobalSet.curIndex14 = 0
        oneGlobalSet.curIndex15 = 0
        oneGlobalSet.curIndex16 = 0
        
        oneGlobalSet.curFavorIndex = 0  // 收藏 学到哪了
        oneGlobalSet.curWrongIndex = 0  // 错误的 学到哪了
        oneGlobalSet.nickName = "游客"
        oneGlobalSet.isVIP = false
        oneGlobalSet.today = ""
        
        context.insert(oneGlobalSet)
        appDelegate.saveContext()
        HomeViewController.getCoreData()
    }
    
    func loginNow() {
        // 1天登录一次
        let today = getToday()
        if today == (nowGlobalSet?.today)! {
            return
        }
        
        nowGlobalSet?.today = today
        appDelegate.saveContext()
        let strToken:String = (nowGlobalSet?.token!)!
        let strNum:String = (nowGlobalSet?.phone!)!
        let strPwd:String = (nowGlobalSet?.pwd!)!
        
        if strToken == "" {
            // 游客注册 register2
//            self.view.makeToastActivity(.center)
            let url = rootUrl + "register2.php"
            Alamofire.request(url).responseString(completionHandler: { (response) in
                if response.result.isSuccess {
                    let str:String = response.result.value!
                    rootResponse(strjson: str, id: PBID.registerTourist)
                    let token:String = (nowGlobalSet?.token!)!
                    // 游客登录下
                    Alamofire.request(rootUrl + "login2.php", method: .get, parameters: ["token": token]).response(completionHandler: { (r) in
                        
                    })
                }else {
                    print("get protocol fail")
                }
//                self.view.hideToastActivity()
            })
        } else if nowGlobalSet?.phone == "" {
            // 游客登录
//            self.view.makeToastActivity(.center)
            let url = rootUrl + "login2.php"
            Alamofire.request(url, method: .get, parameters: ["token": strToken]).responseString { (response) in
                if response.result.isSuccess {
                    let str:String = response.result.value!
                    // 游客登录不需要处理
                    rootResponse(strjson: str, id: PBID.loginTourist)
                }else {
                    print("get protocol fail")
                }
//                self.view.hideToastActivity()
            }
        } else {
            // 手机登录 use phone login
//            self.view.makeToastActivity(.center)
            let url = rootUrl + "login1.php"
            Alamofire.request(url, method: .get, parameters: ["phone": strNum, "pwd": strPwd]).responseString { (response) in
                if response.result.isSuccess {
                    let str:String = response.result.value!
                    rootResponse(strjson: str, id: PBID.loginPhone)
                }else {
                    print("get protocol fail")
                }
//                self.view.hideToastActivity()
            }
        }
    }
    
    func ishy() -> Bool {
        let isv:Bool = (nowGlobalSet?.isVIP)!
        return isv
    }
    func tipsVIP() {
        TipsSwift.showCenterWithText("非会员只能学习前100个单词", duration: 5)
    }
    
    // 点击 顺序学习
    func callbackNormalStudy() -> Void {
        // 太聪明了，赞
        appDelegate.window?.rootViewController?.removeFromParentViewController()
        appDelegate.window?.rootViewController = StudyTabBarController()
        
    }
    // 点击 模拟考试
    func callbackMnks() -> Void {
        
//        print("mnks Study")
        let tabbar = ExamTabBarController()
        tabbar.itype = 8
        
        var total = 1000
        let page = Int((nowGlobalSet?.indexPage)!)
        if  page == 4 {
            total = 1004
        }
        let startID = page*1000
        let endID = startID + total
        // 单词列表
        var arrIds:[Int] = []
        for i in startID..<endID {
            arrIds.append(i)
        }
        arrIds.sort(by: { (_, _) -> Bool in
            arc4random() > arc4random()
        })
        
        for i in 0..<100 {
            tabbar.arrIds.append(arrIds[i])
        }
        
        if ishy() == false {
            TipsSwift.showCenterWithText("非会员只能学习前100个单词", duration: 5)
            tabbar.arrIds = []
            for i in 0..<100 {
                tabbar.arrIds.append(i)
            }
        }
        tabbar.creatSubViewControllers()
        // 跳转到自定义 错题界面
        appDelegate.window?.rootViewController?.removeFromParentViewController()
        appDelegate.window?.rootViewController = tabbar
    }
    // 点击 随机练习
    func callbackSjlx() -> Void {
//        print("sjlx Study")
        
        let tabbar = CustomTabBarController()
        tabbar.itype = 3
        
        var total = 1000
        let page = Int((nowGlobalSet?.indexPage)!)
        if  page == 4 {
            total = 1004
        }
        let startID = page*1000
        let endID = startID + total
        // 单词列表
        var arrIds:[Int] = []
        for i in startID..<endID {
            arrIds.append(i)
        }
        arrIds.sort(by: { (_, _) -> Bool in
            arc4random() > arc4random()
        })
        
        tabbar.arrIds = arrIds
        tabbar.creatSubViewControllers()
        // 跳转到自定义 错题界面
        appDelegate.window?.rootViewController?.removeFromParentViewController()
        appDelegate.window?.rootViewController = tabbar
    }
    // 点击 专项练习
    func callbackZxlx() -> Void {
//        print("zxlx Study")
        // itype为6
        navigationController?.pushViewController(ZxlxViewController(), animated: true)
    }
    
    // 点击 未做题
    func callbackWzt() -> Void {
//        print("Wzt Study")
        let tabbar = CustomTabBarController()
        tabbar.itype = 4
        
        var total = 1000
        let page = Int((nowGlobalSet?.indexPage)!)
        if  page == 4 {
            total = 1004
        }
        let startID = page*1000
        let endID = startID + total
        // 单词列表
        var arrIds:[Int] = []
        for i in startID..<endID {
            if setDoneId.contains(i) == false {
                arrIds.append(i)
            }
        }
//        arrIds.sort(by: { (a, b) -> Bool in
//            a<b
//        })
        arrIds.sort(by: {$0<$1})
        
        tabbar.arrIds = arrIds
        tabbar.creatSubViewControllers()
        // 跳转到自定义 错题界面
        appDelegate.window?.rootViewController?.removeFromParentViewController()
        appDelegate.window?.rootViewController = tabbar
    }
    // 点击 精选难题
    func callbackJxnt() -> Void {
//        print("Jxnt Study")
        let tabbar = CustomTabBarController()
        tabbar.itype = 5
        
        var total = 1000
        let page = Int((nowGlobalSet?.indexPage)!)
        if  page == 4 {
            total = 1004
        }
        let startID = page*1000
        let endID = startID + total
        // 单词列表
        var arrIds:[Int] = []
        for i in startID..<endID {
            let word = gWord[i]
            if (word.characters.count >= 8) && (word.contains("/") == false) {
                arrIds.append(i)
            }
        }
        arrIds.sort(by: {$0<$1})
        tabbar.arrIds = arrIds
        tabbar.creatSubViewControllers()
        // 跳转到自定义 错题界面
        appDelegate.window?.rootViewController?.removeFromParentViewController()
        appDelegate.window?.rootViewController = tabbar
    }
    // 点击 考试记录
    func callbackKsjl() -> Void {
//        print("ksjl Study")
        navigationController?.pushViewController(ExamLogViewController(), animated: true)
    }
    // 点击 成绩排行
    func callbackCjph() -> Void {
        print("cjph Study")
    }
    // 点击 考试须知
    func callbackKsxz() -> Void {
//        print("ksxz Study")
        navigationController?.pushViewController(KsxzViewController(), animated: true)
    }
    // 点击 摇一摇
    func callbackYyy() -> Void {
        print("yyy Study")
    }
    
    // 点击 我的错题
    func callbackWdct() -> Void {
//        print("wdct Study")
        
        if setWrongID.count == 0 {
            TipsSwift.showCenterWithText("没有答错的单词", duration: 3)
            return
        }
        let tabbar = CustomTabBarController()
        tabbar.itype = 1
        
        // 错的单词
        var arrIds:[Int] = []
        for one in setWrongID {
            arrIds.append(one)
        }
        arrIds.sort(by: {$0<$1})
        tabbar.arrIds = arrIds
        tabbar.creatSubViewControllers()
        // 跳转到自定义 错题界面
        appDelegate.window?.rootViewController?.removeFromParentViewController()
        appDelegate.window?.rootViewController = tabbar
    }
    // 点击 我的收藏
    func callbackWdsc() -> Void {
//        print("wdsc Study")
        if setFavorID.count == 0 {
            TipsSwift.showCenterWithText("没有收藏的单词", duration: 3)
            return
        }
        let tabbar = CustomTabBarController()
        tabbar.itype = 2
        
        // 单词列表
        var arrIds:[Int] = []
        for one in setFavorID {
            arrIds.append(one)
        }
        arrIds.sort(by: {$0<$1})
        tabbar.arrIds = arrIds
        tabbar.creatSubViewControllers()
        // 跳转到自定义 错题界面
        appDelegate.window?.rootViewController?.removeFromParentViewController()
        appDelegate.window?.rootViewController = tabbar
    }
    // 点击 学习统计
    func callbackXxtj() -> Void {
//        print("xxtj Study")
        navigationController?.pushViewController(XxtjViewController(), animated: true)
    }
    // 点击 交通标志
    func callbackJtbz() -> Void {
//        print("jtbz Study")
        navigationController?.pushViewController(WordListViewController(), animated: true)
    }
    
}

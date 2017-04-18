//
//  ViewController.swift
//  xxcolor
//
//  Created by ZhangLiangZhi on 2017/2/20.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit
import CoreData
import SnapKit
import GameKit
import AdSupport


//let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

var arrGlobalSet:[CurGlobalSet] = []
var gGlobalSet:CurGlobalSet?

var arrGuanka:[Guanka] = []

var gScore = 0

class ViewController: UIViewController, GKGameCenterControllerDelegate {

    var mainv:UIView!
    var playv:UIView!

    var sv:UIScrollView!
    let maxLevel = 52
    @IBOutlet weak var lblCoin: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        //test
//        autoPlayer()
        self.title = NSLocalizedString("Find Color", comment: "")
//        self.view.backgroundColor = UIColor.darkGray
        
        firstOpenAPP()
        self.mainv = UIView()
        self.view.addSubview(self.mainv)
        self.playv = UIView()
        self.view.addSubview(self.playv)
        mainv.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.width.height.equalTo(self.view)
        }
        playv.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        let cw = self.view.frame.width/2 - 75

        let btnOneSec: BootstrapBtn = BootstrapBtn(frame: CGRect(x:cw, y:190, width:150, height:40), btButtonType: .Success)
        btnOneSec.setTitle(NSLocalizedString("Start Game", comment: ""), for: UIControlState.normal)
        btnOneSec.addTarget(self, action: #selector(playOneMin), for: .touchUpInside)
        self.view.addSubview(btnOneSec)
        
        let btnShowLocal: BootstrapBtn = BootstrapBtn(frame: CGRect(x:cw, y:260, width:150, height:40), btButtonType: .Warning)
        btnShowLocal.setTitle(NSLocalizedString("Local Ranking", comment: ""), for: UIControlState.normal)
        btnShowLocal.addTarget(self, action: #selector(showMyRank), for: .touchUpInside)
        self.view.addSubview(btnShowLocal)
        
        let gcBtn: BootstrapBtn = BootstrapBtn(frame: CGRect(x:cw, y:330, width:150, height:40), btButtonType: .Primary)
        gcBtn.setTitle(NSLocalizedString("All Rank", comment: ""), for: UIControlState.normal)
        gcBtn.addTarget(self, action: #selector(showGC), for: .touchUpInside)
        self.view.addSubview(gcBtn)
        
        
        // 位置修正
        btnShowLocal.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(40)
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).offset(-30)
        }
        
        btnOneSec.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(40)
            make.centerX.equalTo(btnShowLocal)
            make.bottom.equalTo(btnShowLocal.snp.top).offset(-30)
        }
        gcBtn.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(40)
            make.centerX.equalTo(btnShowLocal)
            make.top.equalTo(btnShowLocal.snp.bottom).offset(30)
        }
        
        addScrollView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // 检测设备方向
         NotificationCenter.default.addObserver(self, selector: #selector(receivedRotation), name: .UIDeviceOrientationDidChange, object: nil)
    }

    

    func add100Level() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //        lblCoin.text =   "\(gGlobalSet?.coin)"
        lblCoin.text = String(format: "%d", (gGlobalSet?.coin)!)
    }
    
    func showGC() -> Void {
        MobClick.event("UMGRANK")
        
        let GCVC = GKGameCenterViewController()
        GCVC.gameCenterDelegate = self
        self.present(GCVC, animated: true, completion: nil)
    }
    
    func autoPlayer() {
        let localPlayer = GKLocalPlayer.localPlayer()
        localPlayer.authenticateHandler = {
            (view, error) in
            if view != nil{
                self.present(view!, animated: true, completion:nil)
            }else{
                print(GKLocalPlayer.localPlayer().isAuthenticated)
            }
        }
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    func playOneMin() -> Void {
        let page = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "playID") as! PlayViewController
        navigationController?.pushViewController(page, animated: true)
    }
    
    
    func showMyRank() -> Void {
        MobClick.event("UMLRANK")
        navigationController?.pushViewController(LocalRankViewController(), animated: true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // 获取数据
    func getCoreData() -> Void {
        arrGlobalSet = []
        do {
            arrGlobalSet = try context.fetch(CurGlobalSet.fetchRequest())
        }catch {
            print("Setting coreData error")
        }
        
        arrGuanka = []
        do {
            arrGuanka = try context.fetch(Guanka.fetchRequest())
        }catch {
            print("get guanka error")
        }
        
        if arrGlobalSet.count > 0 {
            gGlobalSet = arrGlobalSet[0]
            
            lblCoin.text = String(format: "%d", (gGlobalSet?.coin)!)
        }
        
    }
    
    // 第一次打开app，加入测试数据
    func firstOpenAPP() -> Void {
        getCoreData()
        
        // 初始化
        if arrGlobalSet.count > 0 {
            return
        }
        let oneGlobalSet = NSEntityDescription.insertNewObject(forEntityName: "CurGlobalSet", into: context) as! CurGlobalSet
        
        
        oneGlobalSet.openCount = 1      // 打开app次数
        oneGlobalSet.evaluate = 0       // 是否评分
        oneGlobalSet.ads = true         // 广告
        oneGlobalSet.coin = 0           // 金币
        oneGlobalSet.diamon = 0         // 钻石
        oneGlobalSet.level = 0          // 等级
        
        
        context.insert(oneGlobalSet)
        appDelegate.saveContext()
        
        getCoreData()
    }
    
    // 把66级关卡加在一个scrollview里面
    func addScrollView() {
        sv = UIScrollView()
        self.view.addSubview(sv)
        sv.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.top.equalTo(lblCoin.snp.bottom).offset(8)
            make.centerX.equalTo(self.view)
        }
        sv.backgroundColor = UIColor.gray
        
        sv.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height*3.25)
        
        // 68个button
        var arrBtns = [UIButton]()
        let ikuan = 4
        let igao = 13
        for i in 0..<igao{
            for j in 0..<ikuan {
                let indexOfKeys = i*ikuan + j
                let btn = UIButton(type: .custom)
                sv.addSubview(btn)
                arrBtns.append(btn)
                
                btn.layer.borderWidth = 2
                btn.layer.borderColor = UIColor.white.cgColor
                
                btn.setTitleColor(UIColor.white, for: UIControlState.normal)
                btn.backgroundColor = UIColor(red: 102/255, green: 184/255, blue: 77/255, alpha: 1)
                
                btn.snp.makeConstraints({ (make) in
                    make.width.equalTo(self.view.snp.width).multipliedBy(1.0/Double(ikuan))
                    make.height.equalTo(self.view.snp.height).multipliedBy(1.0/Double(ikuan))
                    
                    //添加垂直位置约束
                    if i == 0{
                        make.top.equalTo(0)
                    }else{
                        make.top.equalTo(arrBtns[indexOfKeys-ikuan].snp.bottom)
                    }
                    //添加水平位置约束
                    if j == 0{
                        make.left.equalTo(0)
                    }else{
                        make.left.equalTo(arrBtns[indexOfKeys-1].snp.right)
                    }
                })
/*
                // 添加事件
                if (indexOfKeys == Int(s) ) {
                    let a2 = CGFloat(a) * 0.01
                    let a3:CGFloat = 0.5 + a2
                    btn.backgroundColor = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: a3)
                    btn.addTarget(self, action: #selector(goLevelPlay), for: .touchDown)
                }else{
                    btn.backgroundColor = UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
                    btn.addTarget(self, action: #selector(goLevelPlay), for: .touchDown)
                }
 */
                
                btn.setTitle("\(indexOfKeys+1)", for: .normal)
                
            }
        }
        
        
    }
    
    //
    func goLevelPlay() {
        print("play go level")
    }
    
    //通知监听触发的方法
    func receivedRotation(){
        sv.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height*3.25)
        
        // 屏幕方向
//        switch UIDevice.current.orientation {
//        case UIDeviceOrientation.unknown:
//            print("方向未知")
//        case .portrait: // Device oriented vertically, home button on the bottom
//            print("屏幕直立")
//        case .portraitUpsideDown: // Device oriented vertically, home button on the top
//            print("屏幕倒立")
//        case .landscapeLeft: // Device oriented horizontally, home button on the right
//            print("屏幕左在上方")
//        case .landscapeRight: // Device oriented horizontally, home button on the left
//            print("屏幕右在上方")
//        case .faceUp: // Device oriented flat, face up
//            print("屏幕朝上")
//        case .faceDown: // Device oriented flat, face down
//            print("屏幕朝下")
//        }
    }
    
    
}


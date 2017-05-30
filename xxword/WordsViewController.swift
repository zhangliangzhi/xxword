//
//  WordsViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/5/8.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit
import SnapKit

class WordsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var collectionView:UICollectionView!
    var colayout = UICollectionViewFlowLayout()
    var indexPage:Int!
    var firstsTo = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = BG1_COLOR
        indexPage = Int((nowGlobalSet?.indexPage)!)
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(backHome))
        // 检测设备方向
        NotificationCenter.default.addObserver(self, selector: #selector(receivedRotation), name: .UIDeviceOrientationDidChange, object: nil)
        self.automaticallyAdjustsScrollViewInsets = false
        collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: colayout)
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(44+20)
            make.bottom.equalTo(self.view).offset(-49)
        }
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = BG1_COLOR
        collectionView.isPagingEnabled = false
        colayout.scrollDirection = .vertical
        
        colayout.minimumLineSpacing = self.view.frame.width / 20
        colayout.minimumInteritemSpacing = colayout.minimumLineSpacing
        colayout.itemSize = self.view.frame.size
        
        
        colayout.itemSize = CGSize(width: self.view.frame.width/7, height: 30)
        
        colayout.sectionInset = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        indexPage = Int((nowGlobalSet?.indexPage)!)
        HomeViewController.getCoreData()
        collectionView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //通知监听触发的方法
    func receivedRotation(){
        if UIDevice.current.orientation.isPortrait {
        }
//        colayout.itemSize = CGSize(width: self.view.frame.width/7, height: 30)
    }
    
    func initUI() {
        collectionView = UICollectionView()
        self.view.addSubview(collectionView)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(indexPage == 4) {
            return 1004
        }else{
            return 1000
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

        let startID = indexPage * 1000
        let wid = startID + indexPath.row
        let btn = UIButton(type: .system)
        cell.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.edges.equalTo(cell)
        }
        
        let wstatue = getWordStatue(wid: wid)
        if wstatue == 0 {
            btn.backgroundColor = INFO_COLOR
        }else if wstatue == 1{
            btn.backgroundColor = CG_COLOR
        }else if wstatue == 2{
            btn.backgroundColor = DANG_COLOR
        }
        
        btn.setTitle("\(wid+1)", for: .normal)
        btn.tintColor = UIColor.white
        btn.layer.cornerRadius = 5
        if wid == getWid() {
            btn.layer.borderColor = WARN_COLOR.cgColor
            btn.layer.borderWidth = 2
            
        }
        btn.tag = wid
        btn.addTarget(self, action: #selector(clickBtn(_:)), for: .touchUpInside)
        
        // 跳转到第几个单词
        if firstsTo == false {
            firstsTo = true
            let row = getWid() - indexPage*1000
            collectionView.scrollToItem(at: IndexPath.init(row: row, section: 0), at: .centeredVertically, animated: true)
        }
        return cell
    }
    
    func ishy() -> Bool {
        let isv:Bool = (nowGlobalSet?.isVIP)!
        return isv
    }
    func tipsVIP() {
        TipsSwift.showCenterWithText("未解锁只能学习前100个单词", duration: 5)
    }
    
    func clickBtn(_ button:UIButton) {
        let wid = button.tag
        if ishy() == false {
            if wid > 99 {
                tipsVIP()
                return
            }
        }
        if (indexPage == 0) {
            // 显示是1-1000, 实际是0-999
            nowGlobalSet?.curIndex0 = Int32(wid)
        }else if(indexPage == 1) {
            nowGlobalSet?.curIndex1 = Int32(wid)
        }else if(indexPage == 2) {
            nowGlobalSet?.curIndex2 = Int32(wid)
        }else if(indexPage == 3) {
            nowGlobalSet?.curIndex3 = Int32(wid)
        }else if(indexPage == 4) {
            nowGlobalSet?.curIndex4 = Int32(wid)
        }else{
        }
        appDelegate.saveContext()
        
        // 跳转到第一个界面
        appDelegate.window?.rootViewController?.removeFromParentViewController()
        appDelegate.window?.rootViewController = StudyTabBarController()
    }
    
    func getWid() -> Int {
        // 获取id [0,5004)
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
        let wid = Int(curIndex)
        return wid
    }
    
    func getWordStatue(wid:Int) -> Int {
        // 未做题
        var ret = 0
        for one in arrMyErrorID {
            if one.wid == Int32(wid) {
                if one.isRight {
                    // 对
                    ret = 1
                }else{
                    // 错
                    ret = 2
                    break
                }
            }
        }
        return ret
    }
    
}

//
//  XxViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/5/6.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit
import SnapKit

class XxViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    var rootv:UIView!
    var collectionView:UICollectionView!
    let colayout = UICollectionViewFlowLayout()
    var indexPage:Int!
    var firstScroll = false
    var arrTagIndex:[Int:Int] = [:]
    var newImage:UIImageView!
    var curwid = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = BG1_COLOR
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(backHome))
        
        if (nowGlobalSet?.isShowwrCount)! {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "0✅ 0❎", style: .plain, target: self, action: #selector(checkPlayCount))
        }
        
        // 检测设备方向
        NotificationCenter.default.addObserver(self, selector: #selector(receivedRotation), name: .UIDeviceOrientationDidChange, object: nil)
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.

        collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: colayout)
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(44)
            make.bottom.equalTo(self.view).offset(-49)
        }
        collectionView.register(XxCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = BG1_COLOR
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        colayout.scrollDirection = .horizontal
        colayout.minimumLineSpacing = 0
        colayout.itemSize = self.view.frame.size
        
        colayout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height-93)
//        colayout.minimumInteritemSpacing = 0 // 同行内小cell之间的距离
        
        
        indexPage = Int((nowGlobalSet?.indexPage)!)
        
        
        //test将视图滚动到默认单词上, 额这个没起效果 我去
//        collectionView.scrollToItem(at: IndexPath(item: originalID, section: 0), at: .left, animated: false)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        indexPage = Int((nowGlobalSet?.indexPage)!)
        HomeViewController.getCoreData()
        setRightWrongCount()
    }
    
    //通知监听触发的方法
    func receivedRotation(){
        if UIDevice.current.orientation.isPortrait {
        }
        colayout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height-93)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func backHome() {
        appDelegate.window?.rootViewController?.removeFromParentViewController()
        appDelegate.window?.rootViewController = RootTabBarController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell:XxCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! XxCollectionViewCell

        let startID = indexPage * 1000
        cell.wid = startID + indexPath.row
        cell.initWordData()
        cell.curIndexId = indexPath.row
//        cell.createLzLabel(itype: 1)
        
//        print("return cell:",indexPath.row)
        
        // 滚到默认位置先, 在给个提示.
        if firstScroll == false {
            firstScroll = true
            let wid = getWid()
            let ati:Int = wid - (indexPage * 1000)
            if (wid % 1000 ) != 0 {
                collectionView.scrollToItem(at: IndexPath(item: ati, section: 0), at: .left, animated: false)
                //            print("first open")
                TipsSwift.showBottomWithText("自动跳转到上次学习位置", duration: 2)
            }
        }
        
        if arrTagIndex[cell.wid] == nil {
            // 没点击过
            cell.clickCount = 0
        }else {
            // 点击过了
//            cell.selTag(selIndex: arrTagIndex[cell.wid]!)
            
        }
        cell.createLzLabel(itype: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // 将要显示的界面
        let currow = indexPath.row
//        print("will display",index)
        let wid = indexPage*1000 + currow
//        self.title = gWord[wid]
        self.navigationItem.title = gWord[wid]
        self.tabBarItem.title = "\(wid+1)" + "/5004"
        
        curwid = wid
        HomeViewController.getCoreData()
        setRightWrongCount()
    }
    
    
    
    func setTabBarTxt(wid:Int) {
        
    }
    
    func addOneUse(wid:Int, tag:Int) -> Void {
//        print("add one use", tag)
        arrTagIndex[wid] = tag
        
        
    }
    func goNextWord(nextIndexId:Int) -> Void {
        var total = 1000
        if(indexPage == 4) {
            total = 1004
        }
        var nid = nextIndexId
        if nid >= total {
            nid -= 1
        }
        collectionView.scrollToItem(at: IndexPath(item: nid, section: 0), at: .left, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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

    func setRightWrongCount() {
        if (nowGlobalSet?.isShowwrCount)! == false {
            return
        }
        var rcount = 0
        var wcount = 0
        for one in arrMyErrorID {
            if one.wid == Int32(curwid){
                if one.isRight {
                    rcount += 1
                }else {
                    wcount += 1
                }
            }
        }
        let txt:String = "\(rcount)" + "✅ " + "\(wcount)" + "❎"
        self.navigationItem.rightBarButtonItem?.title = txt
    }
    func checkPlayCount() {
        let pv = PlayLogViewController()
        pv.wid = curwid
        self.navigationController?.pushViewController(pv, animated: true)
    }
}

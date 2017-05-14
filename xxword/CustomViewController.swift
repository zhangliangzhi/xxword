//
//  CustomViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/5/6.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit
import SnapKit

class CustomViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    var arrIds:[Int] = []
    var itype = 0   // 1-错误, 2-收藏
    
    var rootv:UIView!
    var collectionView:UICollectionView!
    let colayout = UICollectionViewFlowLayout()
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
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = BG1_COLOR
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        colayout.scrollDirection = .horizontal
        colayout.minimumLineSpacing = 0
        colayout.itemSize = self.view.frame.size
        colayout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height-93)

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
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
        return arrIds.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CustomCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionViewCell

        cell.wid = arrIds[indexPath.row]
        cell.initWordData()
        cell.curIndexId = indexPath.row
        cell.allCount = arrIds.count
        
        // 滚到默认位置先, 在给个提示.
        if firstScroll == false {
            firstScroll = true
            let curidIndex = getCurIndex()
            if curidIndex != 0 {
                collectionView.scrollToItem(at: IndexPath(item: curidIndex, section: 0), at: .left, animated: false)
                if itype == 1{
                    TipsSwift.showBottomWithText("跳转到上次错题位置", duration: 2)
                }else if itype == 2{
                    TipsSwift.showBottomWithText("跳转到上次收藏位置", duration: 2)
                }
                
            }
        }
        
        if arrTagIndex[indexPath.row] == nil {
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
        let wid = arrIds[indexPath.row]
//        self.title = gWord[wid]
        self.navigationItem.title = gWord[wid]
        self.tabBarItem.title = "\(indexPath.row+1)" + "/" + "\(arrIds.count)"
        
        curwid = wid
        HomeViewController.getCoreData()
        setRightWrongCount()
    }
    
    
    
    func setTabBarTxt(wid:Int) {
        
    }
    
    func addOneUse(curid:Int, tag:Int) -> Void {
//        print("add one use", tag)
        arrTagIndex[curid] = tag
        
        
    }
    func goNextWord(nextIdIndex:Int) -> Void {
        if nextIdIndex >= arrIds.count {
            return
        }
        collectionView.scrollToItem(at: IndexPath(item: nextIdIndex, section: 0), at: .left, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getCurIndex() -> Int {
        var curIndex:Int32 = 0
        if (itype == 1) {
            curIndex = (nowGlobalSet?.curWrongIndex)!
        }else if (itype == 2) {
            curIndex = (nowGlobalSet?.curFavorIndex)!
        }
        // 删除了, 就返回打开第一个吧
        var curidIndex = Int(curIndex)
        if curidIndex >= arrIds.count {
            curidIndex = 0
        }
        return curidIndex
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

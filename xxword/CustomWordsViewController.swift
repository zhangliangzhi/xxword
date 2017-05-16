//
//  CustomWordsViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/5/8.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit
import SnapKit

class CustomWordsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    var arrIds:[Int] = []
    var itype = 0   // 1-错误, 2-收藏
    var curIndexId = 0
    
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
        return arrIds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

        let wid = arrIds[indexPath.row]
        let btn = UIButton(type: .system)
        cell.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.edges.equalTo(cell)
        }
        
        curIndexId = getCurIndex()
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
        if curIndexId == indexPath.row {
            btn.layer.borderColor = WARN_COLOR.cgColor
            btn.layer.borderWidth = 2
            
        }
        btn.tag = indexPath.row
        btn.addTarget(self, action: #selector(clickBtn(_:)), for: .touchUpInside)
        
        // 跳转到第几个单词
        if firstsTo == false {
            firstsTo = true
            collectionView.scrollToItem(at: IndexPath.init(row: curIndexId, section: 0), at: .centeredVertically, animated: true)
        }
        return cell
    }
    
    func clickBtn(_ button:UIButton) {
        let tag = button.tag
        let clickIndexID = Int32(tag)
        gClickIndex = clickIndexID
        if itype == 1 {
            nowGlobalSet?.curWrongIndex = clickIndexID
        }else if itype == 2 {
            nowGlobalSet?.curFavorIndex = clickIndexID
        }
        appDelegate.saveContext()
        
        // 跳转到第一个界面
        let tabbar = CustomTabBarController()
        tabbar.itype = itype
        tabbar.arrIds = arrIds
        tabbar.creatSubViewControllers()
        appDelegate.window?.rootViewController?.removeFromParentViewController()
        appDelegate.window?.rootViewController = tabbar
    }
    
    func getCurIndex() -> Int {
        var curIndex:Int32 = 0
        if (itype == 1) {
            curIndex = (nowGlobalSet?.curWrongIndex)!
        }else if (itype == 2) {
            curIndex = (nowGlobalSet?.curFavorIndex)!
        }else {
            // 没编号itype的
            curIndex = gClickIndex
        }
        
        // 删除了, 就返回打开第一个吧
        var curidIndex = Int(curIndex)
        if curidIndex >= arrIds.count {
            curidIndex = 0
        }
        return curidIndex
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

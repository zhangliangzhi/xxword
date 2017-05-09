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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = BG1_COLOR
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
        return gWord.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        cell.backgroundColor = UIColor.gray
        
        let row = indexPath.row
        let btn = UIButton(type: .system)
        cell.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.edges.equalTo(cell)
        }
        
        let wstatue = getWordStatue(wid: row)
        if wstatue == 0 {
            btn.backgroundColor = INFO_COLOR
        }else if wstatue == 1{
            btn.backgroundColor = CG_COLOR
        }else if wstatue == 2{
            btn.backgroundColor = DANG_COLOR
        }
        
        btn.setTitle("\(row+1)", for: .normal)
        btn.tintColor = UIColor.white
        btn.layer.cornerRadius = 5
        if row == getWid() {
            btn.layer.borderColor = WARN_COLOR.cgColor
            btn.layer.borderWidth = 2
        }
        btn.tag = row
        btn.addTarget(self, action: #selector(clickBtn(_:)), for: .touchUpInside)
        return cell
    }
    
    func clickBtn(_ button:UIButton) {
        let row = button.tag
        print("click row", row)
    }
    
    func getWid() -> Int {
        // 获取id [0,5004)
        let windexPage = Int((nowGlobalSet?.indexPage)!)
        var curIndex:Int32 = 0
        if (windexPage == 0) {
            curIndex = (nowGlobalSet?.curIndex0)!
        }else if(windexPage == 1) {
            curIndex = (nowGlobalSet?.curIndex1)!
        }else if(windexPage == 2) {
            curIndex = (nowGlobalSet?.curIndex2)!
        }else if(windexPage == 3) {
            curIndex = (nowGlobalSet?.curIndex3)!
        }else if(windexPage == 4) {
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

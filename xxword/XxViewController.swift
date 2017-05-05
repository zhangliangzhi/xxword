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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = BG1_COLOR
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(backHome))
        // 检测设备方向
        NotificationCenter.default.addObserver(self, selector: #selector(receivedRotation), name: .UIDeviceOrientationDidChange, object: nil)
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
//        rootv = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
//        self.view.addSubview(rootv)
//        rootv.snp.makeConstraints { (make) in
//            make.width.equalTo(self.view)
//            make.top.equalTo(self.view).offset(44)
//            make.bottom.equalTo(self.view).offset(-49)
//        }
//        rootv.backgroundColor = UIColor.red
        
        
        
//        let layout = UICollectionViewFlowLayout()
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
//        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        colayout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = 0
        colayout.itemSize = self.view.frame.size
        
        colayout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height-93)
//        layout.minimumInteritemSpacing = 0 // 同行内小cell之间的距离
        
 
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
        return 1000
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) 
        
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

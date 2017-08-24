//
//  PageViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/8/20.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit
import SnapKit

class PageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    var tablev:UITableView!
    var firstStart:Bool!
    var lastPage:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstStart = true
        lastPage = Int((nowGlobalSet?.lastPage)!)
        
        self.view.backgroundColor = BG1_COLOR
        self.navigationItem.title = "❤️按页码考核👻"
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        tablev = UITableView()
        self.view.addSubview(tablev)
        tablev.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.bottom.equalTo(self.view).offset(-44)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(64)
        }
        
        tablev.delegate = self
        tablev.dataSource = self
        tablev.backgroundColor = BG1_COLOR
        
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 18*278
        return 278
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let ipage = indexPath.row
        
        let lblPage = UILabel()
        cell.addSubview(lblPage)
        lblPage.text = "第" + "\(ipage + 1)" + "页"
        lblPage.snp.makeConstraints { (make) in
            make.center.equalTo(cell)
        }
        
        if firstStart {
            firstStart = false
            
            tableView.scrollToRow(at: IndexPath(row: lastPage-1, section: 0), at: .middle, animated: true)
            
        }
        
        if ipage == lastPage-1 {
            cell.backgroundColor = CG_COLOR
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tabbar = CustomTabBarController()
        tabbar.itype = 3
        
        let ipage = indexPath.row + 1
        nowGlobalSet?.lastPage = Int32(ipage)
        appDelegate.saveContext()
        
        let total = 18
        let startID = indexPath.row * 18
        let endID = startID + total
        
        // 单词列表
        var arrIds:[Int] = []
        for i in startID..<endID {
            arrIds.append(i)
        }
        
        tabbar.arrIds = arrIds
        tabbar.creatSubViewControllers()
        // 跳转到自定义 
        appDelegate.window?.rootViewController?.removeFromParentViewController()
        appDelegate.window?.rootViewController = tabbar
    }
}

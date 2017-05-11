//
//  PlayLogViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/5/12.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit

class PlayLogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tablev:UITableView!
    var arrLog:[MyErrorID] = []
    var wid:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BG1_COLOR
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        tablev = UITableView()
        self.view.addSubview(tablev)
        tablev.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(64)
        }
        
        tablev.delegate = self
        tablev.dataSource = self
        
        getLog()
    }
    
    
    override func willChangeValue(forKey key: String) {
        getLog()
        tablev.reloadData()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLog.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        let nameLabel = UILabel()
        cell.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.center.equalTo(cell)
            
        }
        nameLabel.text = gWord[wid]
        
        return cell
    }
    
    func getLog() {
        arrLog = []
        for one in arrMyErrorID {
            if one.wid == Int32(wid) {
                arrLog.append(one)
            }
        }
//        print("count", arrLog.count)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        print("del", indexPath.row)
        var toidx = 0
        if editingStyle == .delete {
            arrLog.remove(at: indexPath.row)
            for one in arrMyErrorID {
                if one.wid == Int32(wid) {
                    if toidx == indexPath.row {
                        context.delete(one)
                        appDelegate.saveContext()
                        tablev.deleteRows(at: [indexPath], with: .fade)
                        TipsSwift.showTopWithText("成功删除一条学习记录")
                        return
                    }
                    toidx += 1
                }
            }
            
        }
    }
    
    func delAllLog() {
        for one in arrMyErrorID {
            if one.wid == Int32(wid) {
                context.delete(one)
            }
        }
        appDelegate.saveContext()
    }
    
    
}

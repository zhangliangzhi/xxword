//
//  PlayLogViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/5/12.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit
import CoreData

class PlayLogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tablev:UITableView!
    var arrLog:[MyErrorID] = []
    var wid:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BG1_COLOR
        self.title = "学习次数"
        
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(delAllLog))
        
        tablev = UITableView()
        self.view.addSubview(tablev)
        tablev.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.bottom.equalTo(self.view)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(64+30)
        }
        
        tablev.delegate = self
        tablev.dataSource = self
        tablev.backgroundColor = BG1_COLOR
        addHeadV()
        
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
        let cell = UITableViewCell()
        
        // 单词
        let nameLabel = UILabel()
        cell.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(cell)
            make.centerX.equalTo(cell).offset(-10)
        }
        nameLabel.text = gWord[wid]
        nameLabel.textColor = SX3_COLOR
        
        let one = arrLog[indexPath.row]
        
        // 显示时间
        let dformatter = DateFormatter()
        dformatter.dateFormat = "YYYY-MM-dd\n  hh:mm:ss"
        dformatter.timeZone = NSTimeZone.system
        let datestr:String = dformatter.string(from: one.date! as Date)
        let dateLabel = UILabel()
        cell.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.right.equalTo(cell).offset(-15)
            make.centerY.equalTo(cell)
        }
        dateLabel.text = datestr
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        dateLabel.numberOfLines = 0
        dateLabel.textColor = BG2_COLOR
        
        // 是否正确
        let rwLabel = UILabel()
        cell.addSubview(rwLabel)
        rwLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(cell)
            
            make.left.equalTo(cell).offset(10)
        }
        if one.isRight {
            rwLabel.text = "✅"
        }else {
            rwLabel.text = "❎"
        }
        
        // 颜色
        if one.isRight {
            cell.backgroundColor = CG_COLOR
        }else {
            cell.backgroundColor = DANG_COLOR
        }
        
        
        return cell
    }
    
    func addHeadV() {
        let hv = UIView(frame: CGRect(x: 0, y: 0, width: tablev.frame.width, height: 30))
//        tablev.tableHeaderView = hv
        self.view.addSubview(hv)
        hv.snp.makeConstraints { (make) in
            make.centerX.equalTo(tablev)
            make.width.equalTo(tablev)
            make.height.equalTo(30)
            make.bottom.equalTo(tablev.snp.top)
        }
        hv.backgroundColor = BG2_COLOR
        
        let wordLabel = UILabel()
        hv.addSubview(wordLabel)
        wordLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(hv)
            make.centerX.equalTo(hv).offset(-10)
        }
        wordLabel.text = "单词"
        
        let dateLabel = UILabel()
        hv.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(wordLabel)
            make.right.equalTo(hv).offset(-15)
        }
        dateLabel.text = "学习时间"
        
        let rwLabel = UILabel()
        hv.addSubview(rwLabel)
        rwLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(wordLabel)
            make.left.equalTo(hv).offset(10)
        }
        rwLabel.text = "是否正确"
        
        wordLabel.textColor = WZ2_COLOR
        dateLabel.textColor = WZ2_COLOR
        rwLabel.textColor = WZ2_COLOR
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
        
//        print("del", indexPath.row)
        var toidx = 0
        if editingStyle == .delete {
            arrLog.remove(at: indexPath.row)
            for one in arrMyErrorID {
                if one.wid == Int32(wid) {
                    if toidx == indexPath.row {
                        context.delete(one)
                        appDelegate.saveContext()
                        tablev.deleteRows(at: [indexPath], with: .fade)
                        TipsSwift.showCenterWithText("成功删除一条学习记录", duration: 2)
                        return
                    }
                    toidx += 1
                }
            }
            
        }
    }
    
    func delAllLog() {
        if arrLog.count == 0 {
            TipsSwift.showCenterWithText("没有学习记录可删除", duration: 3)
            return
        }
        for one in arrMyErrorID {
            if one.wid == Int32(wid) {
                context.delete(one)
            }
        }
        appDelegate.saveContext()
        arrLog = []
        tablev.reloadData()
        TipsSwift.showCenterWithText("已删除单词所有学习记录", duration: 2)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("sel row", indexPath.row)
        let one = NSEntityDescription.insertNewObject(forEntityName: "MyFavorID", into: context) as! MyFavorID
        one.wid = Int32(wid)
        one.date = NSDate()
        one.indexPage = (nowGlobalSet?.indexPage)!
        context.insert(one)
        appDelegate.saveContext()
        HomeViewController.getCoreData()
//        print("favor count: ", arrMyFavorID.count)
        
        TipsSwift.showCenterWithText("成功加入收藏夹1️⃣次")
    }
    
}

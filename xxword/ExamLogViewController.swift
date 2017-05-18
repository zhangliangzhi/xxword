//
//  ExamLogViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/5/18.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit

class ExamLogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var rootv: UIView!
    var tablev: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = BG1_COLOR
        self.automaticallyAdjustsScrollViewInsets = false
        self.title = "考试记录"
        
        rootv = UIView()
        self.view.addSubview(rootv)
        rootv.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(64)
            make.bottom.equalTo(self.view).offset(-44)
        }
        addHeadV()
        
        tablev = UITableView()
        rootv.addSubview(tablev)
        tablev.snp.makeConstraints { (make) in
            make.width.equalTo(rootv)
            make.bottom.equalTo(rootv)
            make.centerX.equalTo(rootv)
            make.top.equalTo(rootv).offset(30)
        }
        tablev.backgroundColor = BG1_COLOR
        tablev.delegate = self
        tablev.dataSource = self
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(delAllLog))
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrExamList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let oneData = arrExamList[indexPath.row]
        // 分数
        let nameLabel = UILabel()
        cell.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(cell)
            make.centerX.equalTo(cell).offset(-15)
        }
        nameLabel.text = "\(Int(oneData.score))"
        nameLabel.textColor = SX3_COLOR
        
        // 序号
        let indexLabel = UILabel()
        cell.addSubview(indexLabel)
        indexLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(cell).offset(15)
        }
        indexLabel.text = "\(indexPath.row+1)"
        indexLabel.textColor = WARN_COLOR
        
        
        let dformatter = DateFormatter()
        dformatter.dateFormat = "YYYY-MM-dd\nhh:mm:ss"
        dformatter.timeZone = NSTimeZone.system
        let timeStr = dformatter.string(from: oneData.date! as Date)
        // 时间
        let otherLabel = UILabel()
        cell.addSubview(otherLabel)
        otherLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLabel)
            make.right.equalTo(cell).offset(-20)
        }
        otherLabel.text = timeStr
        otherLabel.textColor = INFO_COLOR
        otherLabel.numberOfLines = 0
        
        
        
        return cell
    }
    
    func addHeadV() {
        let hv = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        self.view.addSubview(hv)
        hv.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view)
            make.height.equalTo(30)
            make.top.equalTo(self.view).offset(64)
        }
        hv.backgroundColor = BG2_COLOR
        
        let wordLabel = UILabel()
        hv.addSubview(wordLabel)
        wordLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(hv)
            make.centerX.equalTo(hv).offset(-10)
        }
        wordLabel.text = "考试成绩"
        
        let rwLabel = UILabel()
        hv.addSubview(rwLabel)
        rwLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(wordLabel)
            make.left.equalTo(hv).offset(10)
        }
        rwLabel.text = "ID"
        
        let dateLabel = UILabel()
        hv.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(wordLabel)
            make.right.equalTo(hv).offset(-15)
        }
        dateLabel.text = "考试时间"
        
        
        wordLabel.textColor = WZ2_COLOR
        dateLabel.textColor = WZ2_COLOR
        rwLabel.textColor = WZ2_COLOR
        
        
    }
    
    func delAllLog() {
        if arrExamList.count == 0 {
            TipsSwift.showCenterWithText("没有考试记录可删除", duration: 3)
            return
        }
        for one in arrExamList {
            context.delete(one)
        }
        appDelegate.saveContext()
        arrExamList = []
        tablev.reloadData()
        TipsSwift.showCenterWithText("已清除所有考试记录", duration: 2)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let one = arrExamList[indexPath.row]
            context.delete(one)
            appDelegate.saveContext()
            arrExamList.remove(at: indexPath.row)
            tablev.deleteRows(at: [indexPath], with: .fade)
            TipsSwift.showCenterWithText("成功删除一条学习记录", duration: 2)
            
        }
    }
    
}

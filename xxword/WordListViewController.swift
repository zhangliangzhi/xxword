//
//  WordListViewController.swift
//  xxword
//  错词一览
//  Created by ZhangLiangZhi on 2017/5/17.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit

class WordListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var rootv: UIView!
    var tablev: UITableView!
    var arrIds:[Int] = []
    var arrData:[IdCount] = []
    var otherTitleLabel:UILabel!
    var wtype = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = BG1_COLOR
        self.automaticallyAdjustsScrollViewInsets = false
        self.title = "错词一览"
        
        rootv = UIView()
        self.view.addSubview(rootv)
        rootv.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(64)
            make.bottom.equalTo(self.view).offset(-44)
        }
        
        
        for one in setWrongID {
            arrIds.append(one)
        }
        arrIds.sort(by: {$0<$1})
        
        var arrAll:[MyErrorID] = []
        for one in arrMyErrorID {
            if (one.indexPage == nowGlobalSet?.indexPage) && one.isRight == false {
                arrAll.append(one)
            }
        }
//        arrAll.sort(by: { (a, b) -> Bool in
//            a.date > b.date
//        })
        
        for i in 0..<arrIds.count {
            let wid = arrIds[i]
            var count = 0
            var date:NSDate!
            for one in arrAll {
                if one.wid == Int32(wid) {
                    count += 1
                }
                date = one.date
            }
            let da = IdCount(wid: wid, count: count, index: i, date: date)
            arrData.append(da)
        }
        
        addHeadV()
        
        tablev = UITableView()
        rootv.addSubview(tablev)
        tablev.snp.makeConstraints { (make) in
            make.width.equalTo(rootv)
            make.bottom.equalTo(rootv)
            make.centerX.equalTo(rootv)
            make.top.equalTo(rootv).offset(60)
        }
        tablev.backgroundColor = BG1_COLOR
        tablev.delegate = self
        tablev.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setWrongID.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let wid = arrIds[indexPath.row]
        
        // cell背景颜色
//        if indexPath.row % 2 == 0 {
//            cell.backgroundColor = BG2_COLOR
//        }else {
//            
//        }
//        cell.backgroundColor = BG2_COLOR
        
        // 单词
        let nameLabel = UILabel()
        cell.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(cell)
            make.centerX.equalTo(cell).offset(-15)
        }
        nameLabel.text = gWord[wid]
        nameLabel.textColor = SX3_COLOR
        
        // other
        let otherLabel = UILabel()
        cell.addSubview(otherLabel)
        otherLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLabel)
            make.right.equalTo(cell).offset(-20)
        }
        otherLabel.text = "\(wid+1)"
        otherLabel.textColor = INFO_COLOR
        
        // 序号
        let indexLabel = UILabel()
        cell.addSubview(indexLabel)
        indexLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(cell).offset(15)
        }
        indexLabel.text = "\(indexPath.row+1)"
        indexLabel.textColor = WARN_COLOR
        
        return cell
    }
    
    func addHeadV() {
        let hv = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        //        tablev.tableHeaderView = hv
        self.view.addSubview(hv)
        hv.snp.makeConstraints { (make) in
            make.centerX.equalTo(rootv)
            make.width.equalTo(rootv)
            make.height.equalTo(30)
            make.top.equalTo(rootv.snp.top).offset(30)
        }
        hv.backgroundColor = UIColor.white
        
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
        dateLabel.text = "序号"
        
        otherTitleLabel = UILabel()
        hv.addSubview(otherTitleLabel)
        otherTitleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(wordLabel)
            make.left.equalTo(hv).offset(10)
        }
        otherTitleLabel.text = "排名"
        
        wordLabel.textColor = WZ2_COLOR
        dateLabel.textColor = WZ2_COLOR
        otherTitleLabel.textColor = WZ2_COLOR
    }
}

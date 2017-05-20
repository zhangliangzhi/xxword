//
//  FavorListViewController.swift
//  xxword
//  收藏
//  Created by ZhangLiangZhi on 2017/5/20.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit

class FavorListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var rootv: UIView!
    var tablev: UITableView!
    var arrData:[IdCount] = []
    var otherTitleLabel:UILabel!
    var wtype = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = BG1_COLOR
        self.automaticallyAdjustsScrollViewInsets = false
//        self.title = "收藏单词"
        self.navigationItem.title = "收藏单词"
        
        rootv = UIView()
        self.view.addSubview(rootv)
        rootv.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(64)
            make.bottom.equalTo(self.view).offset(-44)
        }
        
        
        getData()
        
        addHeadV()
        
        tablev = UITableView()
        rootv.addSubview(tablev)
        tablev.snp.makeConstraints { (make) in
            make.width.equalTo(rootv)
            make.bottom.equalTo(rootv).offset(-35)
            make.centerX.equalTo(rootv)
            make.top.equalTo(rootv).offset(60)
        }
        tablev.backgroundColor = BG1_COLOR
        tablev.delegate = self
        tablev.dataSource = self
        
        let btngoStudy = BootstrapBtn(frame: CGRect(), btButtonType: .Success)
        rootv.addSubview(btngoStudy)
        btngoStudy.snp.makeConstraints { (make) in
            make.width.equalTo(rootv).multipliedBy(0.618)
            make.height.equalTo(35)
            make.centerX.equalTo(rootv)
            make.bottom.equalTo(rootv)
        }
        btngoStudy.setTitle("复习收藏单词", for: .normal)
        btngoStudy.addTarget(self, action: #selector(goStudy), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        
        tablev.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let oneData = arrData[indexPath.row]
        let wid:Int = oneData.wid
        
        var str = "\n"
        for one in gDetail[wid] {
            str += one + "\n"
        }
        TipsSwift.showCenterWithText(str, duration: 2)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let oneData = arrData[indexPath.row]
        let wid:Int = oneData.wid
        
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
        otherLabel.numberOfLines = 0
        
        // 序号
        let indexLabel = UILabel()
        cell.addSubview(indexLabel)
        indexLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(nameLabel)
            make.left.equalTo(cell).offset(15)
        }
        indexLabel.text = "\(indexPath.row+1)"
        indexLabel.textColor = WARN_COLOR
        
        // 动态改变内容
        if wtype == 0 {
            otherLabel.text = "\(wid+1)"
        }else if wtype == 1{
            let dcount:Int = oneData.count
            otherLabel.text = "\(dcount)"
        }else if wtype == 2 {
            otherLabel.text = oneData.timeStr
        }
        
        return cell
    }
    
    func addHeadV() {
        let segments = ["单词序号", "收藏次数", "收藏时间"]
        let seg = UISegmentedControl(items: segments)
        self.view.addSubview(seg)
        seg.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(64)
            make.centerX.equalTo(self.view)
            make.height.equalTo(30)
            make.width.equalTo(self.view)
        }
        seg.selectedSegmentIndex = wtype
        seg.addTarget(self, action: #selector(changeSegment(_:)), for: .valueChanged)
        
        // 字段名字
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
            make.left.equalTo(hv).offset(10)
        }
        dateLabel.text = "ID"
        
        otherTitleLabel = UILabel()
        hv.addSubview(otherTitleLabel)
        otherTitleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(wordLabel)
            make.right.equalTo(hv).offset(-15)
        }
        otherTitleLabel.text = "单词序号"
        
        wordLabel.textColor = WZ2_COLOR
        dateLabel.textColor = WZ2_COLOR
        otherTitleLabel.textColor = WZ2_COLOR
    }
    
    func changeSegment(_ segment:UISegmentedControl) {
        wtype = segment.selectedSegmentIndex
        if wtype == 0 {
            otherTitleLabel.text = "单词序号"
        }else if wtype == 1{
            otherTitleLabel.text = "收藏次数"
        }else if wtype == 2 {
            otherTitleLabel.text = "收藏时间"
        }
        sortData()
        tablev.reloadData()
    }
    
    func sortData() {
        if wtype == 0 {
            arrData.sort(by: { (a, b) -> Bool in
                a.index < b.index
            })
        }else if wtype == 1{
            arrData.sort(by: { (a, b) -> Bool in
                a.count > b.count
            })
        }else if wtype == 2 {
            arrData.sort(by: { (a, b) -> Bool in
                a.timeStr > b.timeStr
            })
        }
    }
    
    func getData() {
        arrData = []
        var arrIds:[Int] = []
        for one in setFavorID {
            arrIds.append(one)
        }
        arrIds.sort(by: {$0<$1})
        
        var arrAll:[MyFavorID] = []
        for one in arrMyFavorID {
            if (one.indexPage == nowGlobalSet?.indexPage)  {
                arrAll.append(one)
            }
        }
        
        for i in 0..<arrIds.count {
            let wid = arrIds[i]
            var count = 0
            var timeStr:String!
            for one in arrAll {
                if one.wid == Int32(wid) {
                    count += 1
                    
                    let dformatter = DateFormatter()
                    dformatter.dateFormat = "YYYY-MM-dd\n  hh:mm:ss"
                    dformatter.timeZone = NSTimeZone.system
                    timeStr = dformatter.string(from: one.date! as Date)
                }
            }
            
            let da = IdCount(wid: wid, count: count, index: i, timeStr:timeStr)
            arrData.append(da)
        }
        sortData()
    }
    
    func goStudy() {
        if arrData.count == 0 {
            TipsSwift.showCenterWithText("没有收藏的单词:" + word, duration: 2)
            return
        }
        var arrIds:[Int] = []
        for one in arrData {
            arrIds.append(one.wid)
        }
        let tabbar = CustomTabBarController()
        tabbar.itype = 9
        tabbar.arrIds = arrIds
        tabbar.creatSubViewControllers()
        // 跳转到自定义 错题界面
        appDelegate.window?.rootViewController?.removeFromParentViewController()
        appDelegate.window?.rootViewController = tabbar
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let wid:Int = arrData[indexPath.row].wid
        let word:String = gWord[wid]
        if editingStyle == .delete {
            for i in 0..<arrMyFavorID.count {
                let one = arrMyFavorID[i]
                if one.wid == Int32(wid) {
                    context.delete(one)
                }
            }
            appDelegate.saveContext()
            HomeViewController.getCoreData()
            
            arrData.remove(at: indexPath.row)
            tablev.deleteRows(at: [indexPath], with: .fade)
            TipsSwift.showCenterWithText("已删除收藏单词:" + word, duration: 2)
            
        }
    }
    
}

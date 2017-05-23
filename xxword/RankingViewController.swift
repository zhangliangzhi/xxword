//
//  RankingViewController.swift
//  xxword
//  排行榜
//  Created by ZhangLiangZhi on 2017/5/24.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit
import Alamofire

class RankingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var rootv: UIView!
    var tablev: UITableView!
    var arrData:[oneRank] = []
    var wtype = 0
    var arr1Data:[oneRank] = []
    var arr7Data:[oneRank] = []
    var arr30Data:[oneRank] = []
    var segment:UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = BG1_COLOR
        self.automaticallyAdjustsScrollViewInsets = false
        
        let indexPage = nowGlobalSet?.indexPage
        if indexPage == 0 {
            self.title = "成绩排行 [1-1000)单词"
        }else if indexPage == 1 {
            self.title = "成绩排行 [1000-2000)单词"
        }else if indexPage == 2 {
            self.title = "成绩排行 [2000-3000)单词"
        }else if indexPage == 3 {
            self.title = "成绩排行 [3000-4000)单词"
        }else if indexPage == 4 {
            self.title = "成绩排行 [4000-5004)单词"
        }
        
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
            make.top.equalTo(rootv).offset(62)
        }
        tablev.backgroundColor = BG1_COLOR
        tablev.delegate = self
        tablev.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData(wtype)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let one:oneRank = arrData[indexPath.row]
        let name:String = one.name!
        let uid:String = one.uid!
        if uid == nowGlobalSet?.uid {
            TipsSwift.showCenterWithText("我自己")
        }else {
            TipsSwift.showCenterWithText("用户: " + name)
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let one:oneRank = arrData[indexPath.row]
        let score:Int = one.score!
        let useTime:Int = one.useTime!
        let name:String = one.name!
        let strUseTime = getDtimeStr(useTime)
        let uid:String = one.uid!
        
        // 分数
        let scoreLabel = UILabel()
        cell.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(cell)
            make.centerX.equalTo(cell).offset(30)
        }
        scoreLabel.text = "\(score)分"
        scoreLabel.textColor = WZ1_COLOR
        
        // 用时
        let useTimeLabel = UILabel()
        cell.addSubview(useTimeLabel)
        useTimeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(scoreLabel)
            make.right.equalTo(cell).offset(-20)
        }
        useTimeLabel.text = strUseTime
        useTimeLabel.textColor = WZ1_COLOR
        useTimeLabel.numberOfLines = 0
        
        // 排行
        let indexLabel = UILabel()
        cell.addSubview(indexLabel)
        indexLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(scoreLabel)
            make.left.equalTo(cell).offset(15)
        }
        indexLabel.text = "\(indexPath.row+1)"
        indexLabel.textColor = WARN_COLOR
        
        // 玩家名字
        let userNameLabel = UILabel()
        cell.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(scoreLabel)
            make.left.equalTo(cell).offset(60)
        }
        userNameLabel.text = name
        userNameLabel.textColor = INFO_COLOR
        if uid == nowGlobalSet?.uid {
            userNameLabel.textColor = WARN_COLOR
        }
        
        return cell
    }
    
    func addHeadV() {
        let segments = ["每日排行", "周排行榜", "月排行榜"]
        segment = UISegmentedControl(items: segments)
        self.view.addSubview(segment)
        segment.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(64)
            make.centerX.equalTo(self.view)
            make.height.equalTo(30)
            make.width.equalTo(self.view)
        }
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(changeSegment(_:)), for: .valueChanged)
        
        // 字段名字
        let hv = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30))
        //        tablev.tableHeaderView = hv
        self.view.addSubview(hv)
        hv.snp.makeConstraints { (make) in
            make.centerX.equalTo(rootv)
            make.width.equalTo(rootv)
            make.height.equalTo(30)
            make.top.equalTo(rootv.snp.top).offset(32)
        }
        hv.backgroundColor = UIColor.white
        
        let wordLabel = UILabel()
        hv.addSubview(wordLabel)
        wordLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(hv)
            make.centerX.equalTo(hv).offset(35)
        }
        wordLabel.text = "得分"
        
        
        let indexLabel = UILabel()
        hv.addSubview(indexLabel)
        indexLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(wordLabel)
            make.left.equalTo(hv).offset(10)
        }
        indexLabel.text = "排行"
        
        
        let nameLabel = UILabel()
        hv.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(wordLabel)
            make.left.equalTo(hv).offset(80)
        }
        nameLabel.text = "名字"
        nameLabel.textAlignment = .left
        
        
        let useTimeTitleLabel = UILabel()
        hv.addSubview(useTimeTitleLabel)
        useTimeTitleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(wordLabel)
            make.right.equalTo(hv).offset(-15)
        }
        useTimeTitleLabel.text = "用时"
        
        wordLabel.textColor = WZ2_COLOR
        indexLabel.textColor = WZ2_COLOR
        useTimeTitleLabel.textColor = WZ2_COLOR
        nameLabel.textColor = WZ2_COLOR
    }
    
    func changeSegment(_ segment:UISegmentedControl) {
        wtype = segment.selectedSegmentIndex
        getData(wtype)
    }
    
    func sortData() {
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone.system
        
        if wtype == 0 {
            
        }else if wtype == 1 {
            
        }else if wtype == 2 {
            
        }
    }
    
    // 服务器获取数据
    func getData(_ itype:Int) {
        arrData = []
        if itype == 0 {
            arrData = arr1Data
        }else if itype == 1{
            arrData = arr7Data
        }else if itype == 2{
            arrData = arr30Data
        }
        if arrData.count > 0 {
            tablev.reloadData()
            print("already data return go.")
            return
        }
        
        segment.isUserInteractionEnabled = false
        let url = rootUrl + "rankingCX.php"
        let token:String = (nowGlobalSet?.token)!
        let indexPage:Int = Int((nowGlobalSet?.indexPage)!)
        
        self.view.makeToastActivity(.center)
        Alamofire.request(url, method: .post, parameters: ["token":token, "indexPage":indexPage, "wtype":wtype]).responseString { (response) in
            
            self.view.hideToastActivity()
            self.segment.isUserInteractionEnabled = true
            
            if response.result.isSuccess {
                let str:String = response.result.value!
                
                if let ranks = [oneRank].deserialize(from: str) {
                    for i in 0..<ranks.count {
                        if itype == 0 {
                            self.arr1Data.append(ranks[i]!)
                        }else if itype == 1{
                            self.arr7Data.append(ranks[i]!)
                        }else if itype == 2{
                            self.arr30Data.append(ranks[i]!)
                        }
                    }
                    // 数据排序, 然后显示
                    if itype == 0 {
                        self.arrData = self.arr1Data
                    }else if itype == 1{
                        self.arrData = self.arr7Data
                    }else if itype == 2{
                        self.arrData = self.arr30Data
                    }
                    if self.arrData.count == 0 {
                        TipsSwift.showCenterWithText("还没有排行榜, 快去参加 [单词考试] 吧", duration: 3)
                    }
                    self.tablev.reloadData()
                }else{
                    print("no", str)
                }
            }else {
                print("get protocol fail")
                TipsSwift.showCenterWithText("没有网络, 无法查询排行榜")
            }
        }
    }
    
    func getDtimeStr(_ dtime:Int) -> String {
        var str = ""
        if dtime >= 60 {
            let f:Int = dtime/60
            let m:Int = dtime % 60
            str = String.init(format: "%02d:%02d", arguments: [f, m])
        }else {
            str = String.init(format: "%02d:%02d", arguments: [0, dtime])
        }
        return str
    }
}

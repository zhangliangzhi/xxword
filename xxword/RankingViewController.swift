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
    var firstLoad = true
    var wtype = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = BG1_COLOR
        self.automaticallyAdjustsScrollViewInsets = false
        self.title = "成绩排行"
        
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
        // 只第一次加载数据吧, 慢的半死
        if firstLoad {
            getData()
            firstLoad = false
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let one:oneRank = arrData[indexPath.row]
        let score:Int = one.score!
        let useTime:Int = one.useTime!
        let name:String = one.name!
        let strUseTime = getDtimeStr(useTime)
        
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
            make.left.equalTo(cell).offset(50)
        }
        userNameLabel.text = name
        userNameLabel.textColor = INFO_COLOR
        
        return cell
    }
    
    func addHeadV() {
        let segments = ["每日排行", "周排行榜", "月排行榜"]
        let seg = UISegmentedControl(items: segments)
        self.view.addSubview(seg)
        seg.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(64)
            make.centerX.equalTo(self.view)
            make.height.equalTo(30)
            make.width.equalTo(self.view)
        }
        seg.selectedSegmentIndex = 0
        seg.addTarget(self, action: #selector(changeSegment(_:)), for: .valueChanged)
        
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
        
        tablev.reloadData()
    }
    
    // 服务器获取数据
    func getData() {
        arrData = []
        
        let url = rootUrl + "rankCX.php"
        let token:String = (nowGlobalSet?.token)!
        let indexPage:Int = Int((nowGlobalSet?.indexPage)!)
        
        self.view.makeToastActivity(.center)
        Alamofire.request(url, method: .post, parameters: ["token":token, "indexPage":indexPage]).responseString { (response) in
            
            self.view.hideToastActivity()
            
            if response.result.isSuccess {
                let str:String = response.result.value!
                
                if let ranks = [oneRank].deserialize(from: str) {
                    ranks.forEach({ (rank) in
                        self.arrData.append(rank!)
                    })
                    // 数据排序, 然后显示
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

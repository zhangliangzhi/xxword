//
//  ExamResultViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/5/18.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit
import Alamofire

class ExamResultViewController: UIViewController {

    var rootv: UIView!
    var score:Int!
    var dtime:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = BG1_COLOR
        self.title = "考试成绩"
        
        rootv = UIView()
        self.view.addSubview(rootv)
        rootv.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(64)
            make.bottom.equalTo(self.view)
        }
        
        commitRank()
        initUI()
        
        
    }
    
    func alertTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func commitRank() {
        if nowGlobalSet?.isVIP == false {
            TipsSwift.showTopWithText("未解锁无法提交到 [成绩排行] 哦", duration: 3)
            return
        }
        let url = rootUrl + "rankingTJ.php"
        let token:String = (nowGlobalSet?.token)!
        let indexPage:Int = Int((nowGlobalSet?.indexPage)!)
        let name:String = (nowGlobalSet?.nickName)!
        let uid:String = (nowGlobalSet?.uid)!
        
        Alamofire.request(url, method: .post, parameters: ["name": name, "token":token, "score":score, "indexPage":indexPage, "utime":dtime, "uid":uid]).responseString { (response) in
            if response.result.isSuccess {
                let str:String = response.result.value!
                
                if let data = resRegisterCode.deserialize(from: str) {
                    let code = data.code
                    if code == 0 {
                        // 打败了多少的人
//                        TipsSwift.showCenterWithText("改名成功", duration: 3)
                        print("提交成功")
                    }else if code == -1 {
                    }
                }
            }else {
                print("get protocol fail")
                TipsSwift.showCenterWithText("没有网络, 无法提交到排行榜")
            }
//            self.view.hideToastActivity()
        }
    }
    
    func initUI() {
        let bg = UIImageView(image: UIImage(named: "skin_bg1"))
        rootv.addSubview(bg)
        bg.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        var bgname = "t_fail"
        if score > 90 {
            bgname = "t_perfect"
        }else if score > 60 {
            bgname = "t_sucesse"
        }
        let bg2 = UIImageView(image: UIImage(named: bgname))
        rootv.addSubview(bg2)
        bg2.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).multipliedBy(0.8)
            make.width.equalTo(self.view.snp.width).multipliedBy(0.6 * 1.15)
            make.height.equalTo(self.view.snp.width).multipliedBy(0.6)
        }
        
        
        // 分数
        let scoreLabel = UILabel()
        bg2.addSubview(scoreLabel)
        scoreLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(bg2).offset(3)
            make.centerX.equalTo(bg2)
        }
        scoreLabel.text = "\(Int(score))"
        scoreLabel.textColor = UIColor.white
        scoreLabel.font = UIFont.systemFont(ofSize: 50)
        
        let fenLabel = UILabel()
        bg2.addSubview(fenLabel)
        fenLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(scoreLabel.snp.top).offset(20)
            make.left.equalTo(scoreLabel.snp.right).offset(3)
        }
        fenLabel.text = "分"
        fenLabel.textColor = UIColor.white
        fenLabel.font = UIFont.systemFont(ofSize: 20)
        // 时间
        let nameLabel = UILabel()
        bg2.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(scoreLabel.snp.bottom).offset(-8)
            make.centerX.equalTo(bg2)
        }
        nameLabel.text = "用时: " + getDtimeStr()
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        
        
        
        let buttonOK = BootstrapBtn(frame: CGRect(x: 0, y: 0, width: 50, height: 30), btButtonType: .Warning)
        rootv.addSubview(buttonOK)
        buttonOK.setTitle("确定", for: .normal)
        buttonOK.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        buttonOK.snp.makeConstraints { (make) in
            make.width.equalTo(self.view).multipliedBy(0.618)
            make.centerX.equalTo(self.view)
            make.top.equalTo(bg2.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
    }

    func getDtimeStr() -> String {
        var str = ""
        if dtime >= 60 {
            let f:Int = dtime/60
            let m:Int = dtime % 60
//            str = "\(f)" + ":" + "\(m)"
            str = String.init(format: "%02d:%02d", arguments: [f, m])
        }else {
            str = String.init(format: "%02d:%02d", arguments: [0, dtime])
//            str = "00:" + "\(Int(dtime))"
        }
        return str
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

    func goBack() {
        appDelegate.window?.rootViewController?.removeFromParentViewController()
        appDelegate.window?.rootViewController = RootTabBarController()
    }
}

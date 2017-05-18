//
//  ExamResultViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/5/18.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit

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
        
        initUI()
        
        
    }
    
    func initUI() {
        let bg = UIImageView(image: UIImage(named: "skin_bg1"))
        rootv.addSubview(bg)
        bg.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        let bg2 = UIImageView(image: UIImage(named: "t_perfect"))
        rootv.addSubview(bg2)
        bg2.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).multipliedBy(0.8)
            make.width.equalTo(self.view.snp.width).multipliedBy(0.6 * 1.15)
            make.height.equalTo(self.view.snp.width).multipliedBy(0.6)
        }
        
        // 分数
        let nameLabel = UILabel()
        bg2.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(bg2)
            make.centerX.equalTo(bg2)
        }
        nameLabel.text = getDtimeStr()
        nameLabel.textColor = SX3_COLOR
        
        
        let buttonOK = BootstrapBtn(frame: CGRect(x: 0, y: 0, width: 50, height: 30), btButtonType: .Info)
        rootv.addSubview(buttonOK)
    }

    func getDtimeStr() -> String {
        var str = ""
        if dtime >= 60 {
            let f:Int = dtime/60
            let m:Int = dtime % 60
            str = "\(f)" + ":" + "\(m)"
        }else {
            str = "00:" + "\(dtime)"
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

}

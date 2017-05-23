//
//  KsxzViewController.swift
//  xxword
//  考试须知
//  Created by ZhangLiangZhi on 2017/5/18.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit

class KsxzViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = BG1_COLOR
        self.automaticallyAdjustsScrollViewInsets = false
        self.title = "考试说明"
        
        let nameLabel = UILabel()
        self.view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.view).offset(-20)
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.8)
        }
        nameLabel.text = "考试说明:\n 1. 考试时间为30分钟, 共100题\n 2. 时间结束自动提交成绩. 可查看成绩排名\n 3. 非会员VIP不可提交成绩到排行榜"
        nameLabel.textColor = SX3_COLOR
        nameLabel.numberOfLines = 0
    }


}

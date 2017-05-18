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
            make.centerY.equalTo(self.view)
            make.centerX.equalTo(self.view)
        }
        nameLabel.text = "考试说明:\n考试时间为30/45分钟, 共50/100题,\n 时间结束自动提交成绩. 可查看成绩排名."
        nameLabel.textColor = SX3_COLOR
        nameLabel.numberOfLines = 0
    }


}

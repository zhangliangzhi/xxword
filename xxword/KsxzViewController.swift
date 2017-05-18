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
        self.title = "考核说明"
        
        let nameLabel = UILabel()
        self.view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.view)
            make.centerX.equalTo(self.view)
        }
        nameLabel.text = "考核说明"
        nameLabel.textColor = SX3_COLOR
        nameLabel.numberOfLines = 0
    }


}

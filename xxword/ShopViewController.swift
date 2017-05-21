//
//  ShopViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/4/22.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit
import SnapKit

class ShopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BG1_COLOR
        
        // Do any additional setup after loading the view.
        let btn = BootstrapBtn(frame: CGRect(x: 100, y: 100, width: 100, height: 50), btButtonType: .Success)
        self.view.addSubview(btn)
        btn.setTitle("商店", for: .normal)
        btn.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
        }
    }


}

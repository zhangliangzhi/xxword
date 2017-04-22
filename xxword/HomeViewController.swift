//
//  HomeViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/4/22.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(colorLiteralRed: 233/255, green: 228/255, blue: 217/255, alpha: 1)
        initHomeView() 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func initHomeView() {
        let btn = BootstrapBtn(frame: CGRect(x: 100, y: 100, width: 100, height: 50), btButtonType: .Default)
        self.view.addSubview(btn)
        btn.setTitle("主页", for: .normal)
        btn.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
        }
    }

}

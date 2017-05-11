//
//  ShouCangViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/5/10.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit

class ShouCangViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = BG1_COLOR
        
        // 发声
        let wb = UIWebView()
        self.view.addSubview(wb)
        wb.snp.makeConstraints { (make) in
            make.width.height.equalTo(self.view)
            make.center.equalTo(self.view)
        }
//        let url:URL = URL(string: "https://dict.youdao.com/dictvoice?audio=success&type=1")!
        
        let url:URL = URL(string: "https://fanyi.baidu.com/#en/zh/success")!
        wb.loadRequest(URLRequest(url: url))
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func addDelWord(wid:Int) {
        
    }
    
}

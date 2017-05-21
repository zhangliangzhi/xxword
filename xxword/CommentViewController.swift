//
//  CommentViewController.swift
//  xxword
//  评论单词
//  Created by ZhangLiangZhi on 2017/5/17.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit
import Alamofire


class CommentViewController: UIViewController {

    var rootV: UIView!
    var word: String!
    let url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BG1_COLOR
        
        getNetComment()
    }

    override func viewWillAppear(_ animated: Bool) {
        getNetComment()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getNetComment() {
        Alamofire.request("").responseString { (resp) in
            if resp.result.isFailure {
                TipsSwift.showCenterWithText("没有网络无法获取评论")
                return
            }
            
        }
    }
    
    
}

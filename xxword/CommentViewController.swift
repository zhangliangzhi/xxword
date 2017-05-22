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

    var rootv: UIView!
    var webv:UIWebView!
    let googleUrl   = "https://translate.google.cn/#en/zh-CN/"
    let baiduUrl    = "https://fanyi.baidu.com/#en/zh/"
    let bingUrl     = "https://cn.bing.com/dict/search?q="
    let youdaoUrl   = "https://dict.youdao.com/w/"
    var selIndex:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BG1_COLOR
        
        rootv = UIView()
        self.view.addSubview(rootv)
        rootv.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(20)
            make.bottom.equalTo(self.view)
        }

        initUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        goChange()
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
    
    func initUI() {
        let items = ["google翻译", "百度翻译", "必应翻译", "有道翻译"]
        let segment = UISegmentedControl(items: items)
        rootv.addSubview(segment)
        segment.snp.makeConstraints { (make) in
            make.top.equalTo(rootv)
            make.centerX.equalTo(rootv)
            make.width.equalTo(rootv).multipliedBy(0.98)
            make.height.equalTo(30)
        }
        segment.addTarget(self, action: #selector(changeValue(_:)), for: .valueChanged)
        
        webv = UIWebView()
        rootv.addSubview(webv)
        webv.snp.makeConstraints { (make) in
            make.width.equalTo(rootv)
            make.centerX.equalTo(rootv)
            make.top.equalTo(segment.snp.bottom)
            make.bottom.equalTo(rootv)
        }
        goChange()
    }
    
    func changeValue(_ segment:UISegmentedControl) {
        selIndex = segment.selectedSegmentIndex
        goChange()
    }
    
    func goChange() {
        let word:String = gWord[gClickIndex]
        if selIndex == 0 {
            let url = URLRequest(url: URL(string: googleUrl+word)!)
            webv.loadRequest(url)
        }else if selIndex == 1{
            let url = URLRequest(url: URL(string: baiduUrl+word)!)
            webv.loadRequest(url)
        }
        else if selIndex == 2{
            let url = URLRequest(url: URL(string: bingUrl+word)!)
            webv.loadRequest(url)
        }
        else if selIndex == 3{
            let url = URLRequest(url: URL(string: youdaoUrl+word)!)
            webv.loadRequest(url)
        }

    }
}

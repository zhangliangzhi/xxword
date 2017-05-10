//
//  StudySetViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/5/10.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit

class StudySetViewController: UIViewController {

    var switchMusic:UISwitch!
    var switchSkip:UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = BG1_COLOR
        self.title = "设置"
        
        initUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initUI() {
        let rootv:UIView = UIView()
        self.view.addSubview(rootv)
        rootv.snp.makeConstraints { (make) in
            make.width.equalTo(self.view).multipliedBy(0.8)
            make.top.equalTo(self.view).offset(80)
            make.height.equalTo(300)
            make.centerX.equalTo(self.view)
        }
        rootv.layer.borderWidth = 3
        rootv.layer.borderColor = SX5_COLOR.cgColor
        rootv.backgroundColor = BG2_COLOR
        rootv.layer.cornerRadius = 10
        
        // 播放声音
        let musicLabel = UILabel()
        rootv.addSubview(musicLabel)
        musicLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(rootv).offset(-40)
            make.top.equalTo(rootv).offset(20)
        }
        musicLabel.text = "默认是否播放声音:"
        
        switchMusic = UISwitch(frame: CGRect(x: 0, y: 0, width: 40, height: 60))
        rootv.addSubview(switchMusic)
        switchMusic.snp.makeConstraints { (make) in
            make.centerY.equalTo(musicLabel)
            make.left.equalTo(musicLabel.snp.right).offset(20)
        }
        switchMusic.isOn = (nowGlobalSet?.ismusic)!
        switchMusic.addTarget(self, action: #selector(changeMusic), for: .valueChanged)
        
        // 文字1
        let skipLabel = UILabel()
        rootv.addSubview(skipLabel)
        skipLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(rootv).offset(-40)
            make.top.equalTo(musicLabel.snp.bottom).offset(20)
        }
        skipLabel.text = "自动显示下一个单词:"
        
        switchSkip = UISwitch(frame: CGRect(x: 0, y: 0, width: 40, height: 60))
        rootv.addSubview(switchSkip)
        switchSkip.snp.makeConstraints { (make) in
            make.centerY.equalTo(skipLabel)
            make.left.equalTo(skipLabel.snp.right).offset(20)
        }
        switchSkip.isOn = (nowGlobalSet?.iskipword)!
        switchSkip.addTarget(self, action: #selector(changeSkipWord), for: .valueChanged)
    }

    func changeMusic() {
        print(switchMusic.isOn)
        nowGlobalSet?.ismusic = switchMusic.isOn
        appDelegate.saveContext()
    }
    
    func changeSkipWord() {
        nowGlobalSet?.iskipword = switchSkip.isOn
        appDelegate.saveContext()
    }
    
    
}

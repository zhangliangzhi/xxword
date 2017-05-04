//
//  SxlxViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/4/24.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit
import LTMorphingLabel

class SxlxViewController: UIViewController {

    var sv:UIScrollView!
    var v:UIView!
    
    var wid:Int = 0  // 获取id [0,5004)
    var arrOther:[Int] = [] // 4个解释意思
    var rightIndex = 0  // 对的abcd -> 0123
    var arrImg:[UIImageView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = BG1_COLOR
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(backHome))
        
        // 获取id [0,5004)
        let indexPage:Int = Int((nowGlobalSet?.indexPage)!)
        var curIndex:Int32 = 0
        if (indexPage == 0) {
            curIndex = (nowGlobalSet?.curIndex0)!
        }else if(indexPage == 1) {
            curIndex = (nowGlobalSet?.curIndex1)!
        }else if(indexPage == 2) {
            curIndex = (nowGlobalSet?.curIndex2)!
        }else if(indexPage == 3) {
            curIndex = (nowGlobalSet?.curIndex3)!
        }else if(indexPage == 4) {
            curIndex = (nowGlobalSet?.curIndex4)!
        }else{
        }
        wid = Int(curIndex)
        
//        self.navigationController?.navigationBar.barTintColor = UIColor.gray
        let ew =  cWord.getWord()[wid]
        self.title = ew
        
        // 随机3个其他解释
        initOther3Word()
        
        // 根视图
        v = UIView()
        self.view.addSubview(v)
        v.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.top.equalTo(self.view).offset(44)
            make.bottom.equalTo(self.view).offset(-49)
        }
        
        // 初始化界面
        initWordData()
        createLzLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    func initWordData() {
        sv = UIScrollView()
        self.view.addSubview(sv)
        
        
        // 4个选项
        let v1 = UIButton(type: .system)
        v.addSubview(v1)
        v1.snp.makeConstraints { (make) in
            make.width.height.equalTo(v).multipliedBy(0.5)
            make.centerX.equalTo(v).multipliedBy(0.5)
            make.centerY.equalTo(v).multipliedBy(0.5)
        }
        v1.backgroundColor = BG2_COLOR
        v1.layer.borderWidth = 8
        v1.layer.borderColor = BG1_COLOR.cgColor
        v1.layer.cornerRadius = 30
        v1.tag = 1
        v1.addTarget(self, action: #selector(selButton(_:)), for: .touchUpInside)
        
        
        let v2 = UIButton(type: .system)
        v.addSubview(v2)
        v2.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(v1)
            make.left.equalTo(v1.snp.right).offset(0)
            make.right.equalTo(v)
        }
        v2.backgroundColor = BG2_COLOR
        v2.layer.borderWidth = 8
        v2.layer.borderColor = BG1_COLOR.cgColor
        v2.layer.cornerRadius = 30
        v2.tag = 2
        v2.addTarget(self, action: #selector(selButton(_:)), for: .touchUpInside)
        
        let v3 = UIButton(type: .system)
        v.addSubview(v3)
        v3.snp.makeConstraints { (make) in
            make.width.height.equalTo(v1)
            make.centerX.equalTo(v1)
            make.top.equalTo(v1.snp.bottom).offset(0)
        }
        v3.backgroundColor = BG2_COLOR
        v3.layer.borderWidth = 8
        v3.layer.borderColor = BG1_COLOR.cgColor
        v3.layer.cornerRadius = 30
        v3.tag = 3
        v3.addTarget(self, action: #selector(selButton(_:)), for: .touchUpInside)

        let v4 = UIButton(type: .system)
        v.addSubview(v4)
        v4.snp.makeConstraints { (make) in
            make.width.height.equalTo(v2)
            make.centerX.equalTo(v2)
            make.centerY.equalTo(v3)
        }
        v4.backgroundColor = BG2_COLOR
        v4.layer.borderWidth = 8
        v4.layer.borderColor = BG1_COLOR.cgColor
        v4.layer.cornerRadius = 30
        v4.tag = 4
        v4.addTarget(self, action: #selector(selButton(_:)), for: .touchUpInside)
        
        // ABCD 图片
        let img1 = UIImageView(image: UIImage(named: "normal_a"))
        v1.addSubview(img1)
        img1.snp.makeConstraints { (make) in
            make.bottom.equalTo(v1).offset(-10)
            make.right.equalTo(v1).offset(-10)
            make.width.height.equalTo(40)
        }
        let img2 = UIImageView(image: UIImage(named: "normal_b"))
        v2.addSubview(img2)
        img2.snp.makeConstraints { (make) in
            make.bottom.equalTo(v2).offset(-10)
            make.left.equalTo(v2).offset(10)
            make.width.height.equalTo(40)
        }
        let img3 = UIImageView(image: UIImage(named: "normal_c"))
        v3.addSubview(img3)
        img3.snp.makeConstraints { (make) in
            make.top.equalTo(v3).offset(10)
            make.right.equalTo(v3).offset(-10)
            make.width.height.equalTo(40)
        }
        let img4 = UIImageView(image: UIImage(named: "normal_d"))
        v4.addSubview(img4)
        img4.snp.makeConstraints { (make) in
            make.top.equalTo(v4).offset(10)
            make.left.equalTo(v4).offset(10)
            make.width.height.equalTo(40)
        }
        arrImg = [img1, img2, img3, img4]
        
        // 文本处理
        var arrV = [v1, v2, v3, v4]
        for i in 0..<4 {
            let inv = arrV[i]
            let nid = arrOther[i]
            let arrS = cDetail.getD()[nid]
            let sl1 = getStr(arr: arrS)
            let label1 = UILabel()
            inv.addSubview(label1)
            label1.snp.makeConstraints { (make) in
                make.width.height.equalTo(inv).multipliedBy(0.82)
                make.center.equalTo(inv)
            }
            //        label1.text = sl1
            label1.numberOfLines = 0
            label1.lineBreakMode = .byWordWrapping
            label1.adjustsFontSizeToFitWidth = true
            //        label1.textColor = WZ1_COLOR
            //富文本设置
            let attributeString = NSMutableAttributedString(string:sl1)
            var indexStart:Int = 0
            var indexI = 0
            for s in arrS {
                let count = s.characters.count + 1
                //            print(count)
                if (indexI % 2) == 0 {
                    attributeString.addAttribute(NSForegroundColorAttributeName, value: WZ1_COLOR, range: NSRange.init(location: indexStart, length: count))
                }else {
                    attributeString.addAttribute(NSForegroundColorAttributeName, value: WZ4_COLOR, range: NSRange.init(location: indexStart, length: count))
                    //                attributeString.addAttribute(NSBackgroundColorAttributeName, value: UIColor.gray, range: NSRange.init(location: indexStart, length: count))
                }
                
                indexI += 1
                indexStart += count
            }
            label1.attributedText = attributeString
        }
        
        
        
    }
    
    func backHome() {
        appDelegate.window?.rootViewController?.removeFromParentViewController()
        appDelegate.window?.rootViewController = RootTabBarController()
    }
    
    func selButton(_ button:UIButton) -> Void {
        let selIndex = button.tag - 1
        if selIndex == rightIndex {
            // 正确 ✅
            let img = arrImg[rightIndex]
            img.image = UIImage(named: "success_gx")
        }else {
            // 错误
            let rimg = arrImg[selIndex]
            rimg.image = UIImage(named: "wrong_red")
            
            let img = arrImg[rightIndex]
            img.image = UIImage(named: "success_gx")
        }
//        print(button.tag)
    }
    
    func getStr(arr:[String]) -> String {
        var ret:String = ""
        for a in arr {
            ret = ret + a + "\n"
        }
        return ret
    }

    func initOther3Word() {
        arrOther.append(wid)
        //test 17 -> 5000
        let allwordcount:Int32 = 17
        ocseed(Int32(wid))
        for i in 0..<3 {
            var iran:Int = Int(ocrand() % allwordcount)
            if (i == 0) && (iran == arrOther[0] ) {
                iran = Int(ocrand() % allwordcount)
            }else if (i == 1) && (iran == arrOther[0] || iran == arrOther[1]) {
                iran = Int(ocrand() % allwordcount)
            }else if (i == 2) && (iran == arrOther[0] || iran == arrOther[1] || iran == arrOther[2]) {
                iran = Int(ocrand() % allwordcount)
            }
            arrOther.append(iran)
        }
        arrOther.sort { (_, _) -> Bool in
            arc4random() > arc4random()
        }
//        print(arrOther)
        for i in 0..<4 {
            if arrOther[i] == wid {
                rightIndex = i
            }
        }
//        print(rightIndex)
    }
    
    // 动态粒子字体
    func createLzLabel() {
        let ew =  cWord.getWord()[wid]
        let lzLabel = LTMorphingLabel()
        lzLabel.morphingEffect = .anvil
        v.addSubview(lzLabel)
        lzLabel.snp.makeConstraints { (make) in
            make.center.equalTo(v)
        }
        lzLabel.text = ew
        lzLabel.font = UIFont.systemFont(ofSize: 25)
        lzLabel.textColor = SX3_COLOR
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

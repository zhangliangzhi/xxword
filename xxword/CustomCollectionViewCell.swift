//
//  CustomCollectionViewCell.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/5/5.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit
import SnapKit
import LTMorphingLabel
import CoreData

class CustomCollectionViewCell: UICollectionViewCell {

    // 在外面的会重复利用, 要在init里面赋值才可以!注意
    var curIndexId = 0  // 序列号
    var wid:Int = 0  // 获取id [0,5004)
    var arrOther:[Int] = [] // 4个解释意思
    var rightIndex = 0  // 对的abcd -> 0123
    var arrImg:[UIImageView] = []
    var centerLabel:LTMorphingLabel!
    var clickCount:Int = 0
    var itype = 0   // 1-错误, 2-收藏
    var allCount = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.backgroundColor = BG1_COLOR
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func initWordData() {
        // 随机3个其他解释
        initOther3Word()
        // 初始化 点击次数
        clickCount = 0
        
        let v = self.contentView
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
//            make.width.height.equalTo(v).multipliedBy(0.5)
            make.width.height.equalTo(v1)
            make.top.bottom.equalTo(v1)
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
            let arrS = gDetail[nid]
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
        
        
        if ishy() == false {
            if wid>=99 {
                self.clickCount = 1
            }
        }
        
    }
    
    
    func selButton(_ button:UIButton) -> Void {
        if clickCount > 0 {
            return
        }
        
        let selIndex = button.tag - 1
        selTag(selIndex: selIndex)
        let sv = firstViewController() as! CustomViewController
        sv.addOneUse(curid: curIndexId, tag: selIndex)
        
        // 插入数据
        let oneWrong = NSEntityDescription.insertNewObject(forEntityName: "MyErrorID", into: context) as! MyErrorID
        oneWrong.wid = Int32(wid)
        oneWrong.indexPage = Int32(wid / 1000)
        if oneWrong.indexPage == 5 {
            oneWrong.indexPage = 4
        }
        oneWrong.date = NSDate()
        if selIndex == rightIndex {
            oneWrong.isRight = true
            // 正确的话自动跳转到下一页去
        }else{
            oneWrong.isRight = false
        }
        context.insert(oneWrong)
        // 保持学习到的当前序号
        var nextIndexId = curIndexId + 1
        if itype == 1 {
            if nextIndexId >= allCount {
                nextIndexId -= 1
            }
            nowGlobalSet?.curWrongIndex = Int32(nextIndexId)
        }else if itype == 2 {
            if nextIndexId >= allCount {
                nextIndexId -= 1
            }
            nowGlobalSet?.curFavorIndex = Int32(nextIndexId)
        }
        
        appDelegate.saveContext()
        // 保存后, 数据马上更新到最新的
        HomeViewController.getCoreData()
        if oneWrong.isRight == false {
            // 答错 更新次数
            sv.setRightWrongCount()
        }
        
        gClickIndex = Int32(curIndexId)
        // 是否自动跳到下一题
        if oneWrong.isRight {
            if (nowGlobalSet?.iskipword)! {
                sv.goNextWord(nextIdIndex: self.curIndexId+1)
            }
        }
        
    }
    
    func selTag(selIndex:Int) {
        clickCount += 1
        if selIndex == rightIndex {
            // 正确 ✅
            let img = arrImg[rightIndex]
            img.image = UIImage(named: "success_gx")
//            createLzLabel(itype: 1)
        }else {
            // 错误
            let rimg = arrImg[selIndex]
            rimg.image = UIImage(named: "wrong_red")
            
            let img = arrImg[rightIndex]
            img.image = UIImage(named: "success_gx")
//            createLzLabel(itype: 2)
        }
    }
    
    func firstViewController() -> UIViewController? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let responder = view?.next {
                if responder.isKind(of: UIViewController.self){
                    return responder as? UIViewController
                }
            }
        }
        return nil
    }
    
    
    func getStr(arr:[String]) -> String {
        var ret:String = ""
        for a in arr {
            ret = ret + a + "\n"
        }
        return ret
    }
    
    func initOther3Word() {
        ocseed(Int32(wid*8 + 8888))
        
        var setID = Set<Int>()
        let allwordcount:Int32 = 5000
        for _ in 0..<100 {
            let iran:Int = Int(ocrand() % allwordcount)
            setID.insert(iran)
            setID.remove(wid)
            if setID.count >= 3 {
                break
            }
        }
        arrOther = []
        arrOther.append(wid)
        for oid in setID {
            arrOther.append(oid)
        }
        
        // 乱排序
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
    
    func ishy() -> Bool {
        let isv:Bool = (nowGlobalSet?.isVIP)!
        return isv
    }
    // 动态粒子字体
    func createLzLabel(itype:Int) {
        if centerLabel != nil {
            centerLabel.removeFromSuperview()
            centerLabel = nil
        }
        var ew =  gWord[wid]
        if ishy() == false {
            if wid>=99 {
                ew = "非会员无法学习"
            }
        }
        centerLabel = LTMorphingLabel()
        if itype == 1 {
            centerLabel.morphingEffect = .anvil
        }else{
            centerLabel.morphingEffect = .burn
        }
        
        self.contentView.addSubview(centerLabel)
        centerLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.contentView)
        }
        centerLabel.text = ew
        centerLabel.font = UIFont.systemFont(ofSize: 25)
        centerLabel.textColor = SX3_COLOR
    }
    
}

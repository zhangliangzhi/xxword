//
//  ViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/4/1.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext
var arrGlobalSet:[CurGlobalSet] = []
var arrStudyWord:[StudyWord] = []
var nowGlobalSet:CurGlobalSet?


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("h")
        let btn = UIButton(type: .contactAdd)
        self.view.addSubview(btn)
        btn.setTitle("Go", for: .normal)
        btn.frame = CGRect(x: 88, y: 88, width: 88, height: 88)
        btn.addTarget(self, action: #selector(btnGo), for: .touchUpInside)
//        btn.center = self.view.center
        
        
        let button:UIButton = UIButton(type: .system)
        //设置按钮位置和大小
        button.frame = CGRect(x:10, y:150, width:100, height:30)
        //设置按钮文字
        button.setTitle("按钮", for:.normal)
        self.view.addSubview(button)
        
        //test
        self.navigationController?.pushViewController(SignUpViewController(), animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCoreData()
        firstOpenAPP()
        initDataFromCoreData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func btnGo() {
//        self.present(LoginViewController(), animated: true) { 
//            print("hi")
//        }
        self.navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    func initDataFromCoreData() {
        print(nowGlobalSet?.diamond)
    }
    
    func getCoreData() -> Void {
        arrStudyWord = []
        arrGlobalSet = []
        
        do {
            arrStudyWord = try context.fetch(StudyWord.fetchRequest())
        }catch {
            print("StudyWord coreData error")
        }
        
        do {
            arrGlobalSet = try context.fetch(CurGlobalSet.fetchRequest())
        }catch {
            print("Setting coreData error")
        }
        
        if arrGlobalSet.count > 0 {
            nowGlobalSet = arrGlobalSet[0]
        }
        
        //        print(nowGlobalSet)
    }
    
    // 第一次打开app，加入测试数据
    func firstOpenAPP() -> Void {
        // 初始化
        if arrGlobalSet.count > 0 {
            return
        }
        
        let oneGlobalSet = NSEntityDescription.insertNewObject(forEntityName: "CurGlobalSet", into: context) as! CurGlobalSet
        
        oneGlobalSet.coin = 0
        oneGlobalSet.diamond = 0
        oneGlobalSet.exp = 0
        oneGlobalSet.phone = ""
        oneGlobalSet.pwd = ""
        oneGlobalSet.token = ""
        oneGlobalSet.vip = 0
        
        
        context.insert(oneGlobalSet)
        appDelegate.saveContext()
        getCoreData()
    }
}


//
//  SxlxViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/4/24.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit

class SxlxViewController: UIViewController {

    var sv:UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = BG1_COLOR
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(backHome))
        
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
//        self.navigationController?.navigationBar.barTintColor = UIColor.gray
        let id:Int = Int(curIndex)
        let ew =  cWord.getWord()[id]
        self.title = ew
        
        initWordData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initWordData() {
        sv = UIScrollView()
        self.view.addSubview(sv)

    }
    
    func backHome() {
        appDelegate.window?.rootViewController?.removeFromParentViewController()
        appDelegate.window?.rootViewController = RootTabBarController()
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

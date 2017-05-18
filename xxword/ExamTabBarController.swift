//
//  ExamTabBarController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/4/28.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit

class ExamTabBarController: UITabBarController {
    var itype:Int!
    var arrIds:[Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func creatSubViewControllers(){
        let v1  = WordExamViewController()
        v1.itype = self.itype
        v1.arrIds = self.arrIds
        let item1 : UITabBarItem = UITabBarItem (title: "1/1", image: UIImage(named: "fangkuai"), selectedImage: UIImage(named: "fangkuai"))
        v1.tabBarItem = item1
        
        let v2 = CustomWordsViewController()
        let t2 = "单词列表"
        v2.arrIds = arrIds
        v2.itype = itype
        let item2 : UITabBarItem = UITabBarItem (title: t2, image: UIImage(named: "wrodlist"), selectedImage: UIImage(named: "wrodlist"))
        v2.tabBarItem = item2
        
        let n1 = UINavigationController(rootViewController: v1)
        let n2 = UINavigationController(rootViewController: v2)
        let tabArray = [n1, n2]
        self.viewControllers = tabArray
        
        //默认选中的是游戏主界面视图
        self.selectedIndex = 0
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

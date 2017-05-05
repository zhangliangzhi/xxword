//
//  StudyTabBarController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/4/28.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit

class StudyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        creatSubViewControllers()
        // Do any additional setup after loading the view.
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func creatSubViewControllers(){
        let v1  = XxViewController()
        v1.title = "v1"
        let item1 : UITabBarItem = UITabBarItem (title: "本题答案", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        v1.tabBarItem = item1
        
        let v2 = SxlxViewController()
        let item2 : UITabBarItem = UITabBarItem (title: "0/1000", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
        v2.tabBarItem = item2
        
        let v3 = FavorViewController()
        let item3 : UITabBarItem = UITabBarItem (title: "收藏", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
        v3.tabBarItem = item3
        
        let v4 = FavorViewController()
        let item4 : UITabBarItem = UITabBarItem (title: "设置", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
        v4.tabBarItem = item4
        
        let n1 = UINavigationController(rootViewController: v1)
        let n2 = UINavigationController(rootViewController: v2)
        let n3 = UINavigationController(rootViewController: v3)
        let n4 = UINavigationController(rootViewController: v4)
        //定义tab按钮添加个badge小红点值
//        n1.tabBarItem.badgeValue = "8"
        let tabArray = [n1, n2, n3, n4]
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

//
//  RootTabBarController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/4/22.
//  Copyright © 2017年 xigk. All rights reserved.
//

import Foundation

class RootTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        creatSubViewControllers()
    }
    
    func creatSubViewControllers(){
        let v1  = HomeViewController ()
        let item1 : UITabBarItem = UITabBarItem (title: "第一页面", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        v1.tabBarItem = item1
        
        let v2 = ShopViewController()
        let item2 : UITabBarItem = UITabBarItem (title: "第二页面", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
        v2.tabBarItem = item2
        
        let v3 = FavorViewController()
        let item3 : UITabBarItem = UITabBarItem (title: "第三页面", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
        v3.tabBarItem = item3
        
        let tabArray = [v1, v2, v3]
        self.viewControllers = tabArray
    }
}

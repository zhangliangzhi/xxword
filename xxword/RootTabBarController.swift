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
        // rgb 241,235,223
    }
    
    func creatSubViewControllers(){
        let v1  = HomeViewController()
        let item1 : UITabBarItem = UITabBarItem (title: "首页", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        v1.tabBarItem = item1
        
        
        let v2 = FavorViewController()
        let item2 : UITabBarItem = UITabBarItem (title: "商店", image: UIImage(named: "shop"), selectedImage: UIImage(named: "shop_1"))
        v2.tabBarItem = item2
        
        
        let v3 = FavorViewController()
        let item3 : UITabBarItem = UITabBarItem (title: "交流", image: UIImage(named: "message"), selectedImage: UIImage(named: "message_1"))
        v3.tabBarItem = item3

//        let v4 = FavorViewController()
        let v4 = FavorListViewController()
        let item4 : UITabBarItem = UITabBarItem (title: "收藏", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
        v4.tabBarItem = item4
        
        
        let v5 = MeViewController()
        let item5 : UITabBarItem = UITabBarItem (title: "我的", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
        v5.tabBarItem = item5
        
        let n1 = UINavigationController(rootViewController: v1)
        let n2 = UINavigationController(rootViewController: v2)
        let n4 = UINavigationController(rootViewController: v4)
        let n5 = UINavigationController(rootViewController: v5)
        let tabArray = [n1, n2, v3, n4, n5]
        self.viewControllers = tabArray
    }
}

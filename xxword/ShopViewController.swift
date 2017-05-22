//
//  ShopViewController.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/4/22.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyStoreKit

class ShopViewController: UIViewController {

    var outBuyButton:BootstrapBtn!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BG1_COLOR
        self.navigationItem.title = "商店"
        // Do any additional setup after loading the view.
        
        
        initUI()
        reqShop()
    }

    func reqShop()  {
        SwiftyStoreKit.retrieveProductsInfo(["xxwordHY"]) { result in
            if let product = result.retrievedProducts.first {
                let priceString = product.localizedPrice!
                print("Product: \(product.localizedDescription), price: \(priceString)")
            }
            else if let invalidProductId = result.invalidProductIDs.first {
//                return alertWithTitle("Could not retrieve product info", message: "Invalid product identifier: \(invalidProductId)")
                print("can not retrieve product info")
            }
            else {
                print("Error: \(result.error)")
            }
        }
    }
    
    func initUI() {
        
        
        outBuyButton = BootstrapBtn(frame: CGRect(x: 0, y: 0, width: 50, height: 30), btButtonType: .Success)
        self.view.addSubview(outBuyButton)
        outBuyButton.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.8)
            make.height.equalTo(50)
        }
        outBuyButton.setTitle("月会员VIP \n 🛒￥30.00", for: .normal)
        outBuyButton.titleLabel?.numberOfLines = 0
        
        let labelDescVip = UILabel()
        self.view.addSubview(labelDescVip)
        labelDescVip.snp.makeConstraints { (make) in
            make.bottom.equalTo(outBuyButton.snp.top).offset(-30)
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view)
            make.height.equalTo(20)
        }
        labelDescVip.textAlignment = .center
        labelDescVip.text = "购买VIP会员服务, \n可无限制使用[象形单词]"
        labelDescVip.textColor = WZ1_COLOR
        labelDescVip.numberOfLines = 0
        
    }
}

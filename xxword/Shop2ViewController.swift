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

class Shop2ViewController: UIViewController {
    var rootv: UIView!
    var outBuyButton:UIButton!
    var outRestoreButton:BootstrapBtn!
    var webv:UIWebView!
    let PRODUCT_Id1:String = "com.xigk.xxword.1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BG1_COLOR
        self.navigationItem.title = "永久解锁单词"
        // Do any additional setup after loading the view.
        
        MobClick.event("WatchShopView")
        
        rootv = UIView()
        self.view.addSubview(rootv)
        rootv.snp.makeConstraints { (make) in
            make.width.equalTo(self.view)
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(64)
            make.bottom.equalTo(self.view).offset(-44)
        }
        
        initUI()
        reqShop()
    }
    
    func initUI() {
        // 说明
        let labelDescVip = UILabel()
        rootv.addSubview(labelDescVip)
        labelDescVip.snp.makeConstraints { (make) in
            make.top.equalTo(rootv).offset(10)
            make.centerX.equalTo(rootv)
            make.width.equalTo(rootv).multipliedBy(0.9)
        }
        labelDescVip.textAlignment = .center
        labelDescVip.text = "没有解锁只能学习前100个单词。\n未解锁单词考试无法参加排行榜。\n解锁所有单词可无限制使用。"
        labelDescVip.textColor = WZ1_COLOR
        labelDescVip.numberOfLines = 0
        
        // 购买
        outBuyButton =  BootstrapBtn(frame: CGRect(x: 0, y: 0, width: 50, height: 30), btButtonType: .Warning)
        rootv.addSubview(outBuyButton)
        outBuyButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(rootv)
            make.centerY.equalTo(rootv).offset(-60)
            make.width.equalTo(rootv).multipliedBy(0.8)
            make.height.equalTo(68)
        }
        outBuyButton.setTitle("￥30  🔐单词", for: .normal)
        outBuyButton.titleLabel?.textAlignment = .center
        outBuyButton.titleLabel?.font = UIFont.systemFont(ofSize: 38)
        outBuyButton.addTarget(self, action: #selector(buyOneMonthPurchase), for: .touchUpInside)
//        outBuyButton.layer.borderColor = UIColor.white.cgColor
//        outBuyButton.layer.borderWidth = 1
        outBuyButton.layer.cornerRadius = 34
//        outBuyButton.backgroundColor = CG_COLOR
        outBuyButton.setTitleColor(UIColor.white, for: .normal)
        
        // 恢复购买
        outRestoreButton = BootstrapBtn(frame: CGRect(x: 0, y: 0, width: 50, height: 30), btButtonType: .Danger)
        rootv.addSubview(outRestoreButton)
        outRestoreButton.snp.makeConstraints { (make) in
            make.width.equalTo(rootv).multipliedBy(0.4)
            make.height.equalTo(38)
            make.top.equalTo(outBuyButton.snp.bottom).offset(50)
            make.centerX.equalTo(rootv)
        }
        outRestoreButton.setTitle("恢复购买", for: .normal)
        outRestoreButton.titleLabel?.numberOfLines = 0
        outRestoreButton.titleLabel?.textAlignment = .center
        outRestoreButton.addTarget(self, action: #selector(restoreOneMonthPurchase), for: .touchUpInside)
        
        // 月
        let outLabelKF = UILabel()
        rootv.addSubview(outLabelKF)
        outLabelKF.snp.makeConstraints { (make) in
            make.centerX.equalTo(outBuyButton)
            make.bottom.equalTo(outBuyButton.snp.top).offset(-8)
        }
        outLabelKF.textAlignment = .center
        outLabelKF.text = "🚀永久解锁所有单词，使用无任何限制。"
        outLabelKF.numberOfLines = 0
        outLabelKF.textColor = WZ1_COLOR
        outLabelKF.font = UIFont.systemFont(ofSize:16)
        
        // 自动续期
        let outLabelAuto = UILabel()
        rootv.addSubview(outLabelAuto)
        outLabelAuto.snp.makeConstraints { (make) in
            make.centerX.equalTo(outBuyButton)
            make.top.equalTo(outBuyButton.snp.bottom).offset(10)
        }
        outLabelAuto.textAlignment = .center
        outLabelAuto.text = "解锁所有单词, 快乐学习"
        outLabelAuto.textColor = WZ2_COLOR
        outLabelAuto.font = UIFont.systemFont(ofSize: 13)
        
    }
    
    
    func reqShop()  {
        SwiftyStoreKit.retrieveProductsInfo([PRODUCT_Id1]) { result in
            if let product = result.retrievedProducts.first {
//                let priceString = product.localizedPrice!
//                let txt:String = "🛒" + product.localizedTitle + " \n" + priceString
//                self.outBuyButton.setTitle(txt, for: .normal)
//                print("Product title: \(product.localizedTitle), price: \(priceString)")
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
    
    
    
    func buyOneMonthPurchase() {
//        print("buy one click")
        MobClick.event("WantBuyVIP")
        
        self.view.makeToastActivity(.center)
        outBuyButton.isUserInteractionEnabled = false
        outRestoreButton.isUserInteractionEnabled = false
        SwiftyStoreKit.purchaseProduct(PRODUCT_Id1, atomically: true) { result in
            self.view.hideToastActivity()
            self.outBuyButton.isUserInteractionEnabled = true
            self.outRestoreButton.isUserInteractionEnabled = true
            if case .success(let purchase) = result {
                // Deliver content from server, then:
                if purchase.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(purchase.transaction)
                }
                
            }
            if let alert = self.alertForPurchaseResult(result) {
                self.showAlert(alert)
            }
            
        }
    }
    func showAlert(_ alert: UIAlertController) {
        
        guard self.presentedViewController != nil else {
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
    func alertForPurchaseResult(_ result: PurchaseResult) -> UIAlertController? {
        switch result {
        case .success(let purchase):
            print("Purchase Success: \(purchase.productId)")
            verifyPurchase()
            MobClick.event("DoneBuyVIP")
            return alertWithTitle("🎉恭喜🎉", message: "已永久解锁所有单词!")
        case .error(let error):
            print("Purchase Failed: \(error)")
            delVip()
            switch error.code {
            case .unknown: return alertWithTitle("Purchase failed", message: "无法连接到 iTunes Store")
            case .clientInvalid: // client is not allowed to issue the request, etc.
                return alertWithTitle("Purchase failed", message: "Not allowed to make the payment")
            case .paymentCancelled: // user cancelled the request, etc.
                return nil
            case .paymentInvalid: // purchase identifier was invalid, etc.
                return alertWithTitle("Purchase failed", message: "The purchase identifier was invalid")
            case .paymentNotAllowed: // this device is not allowed to make the payment
                return alertWithTitle("Purchase failed", message: "The device is not allowed to make the payment")
            case .storeProductNotAvailable: // Product is not available in the current storefront
                return alertWithTitle("Purchase failed", message: "The product is not available in the current storefront")
            case .cloudServicePermissionDenied: // user has not allowed access to cloud service information
                return alertWithTitle("Purchase failed", message: "Access to cloud service information is not allowed")
            case .cloudServiceNetworkConnectionFailed: // the device could not connect to the nework
                return alertWithTitle("Purchase failed", message: "Could not connect to the network")
            case .cloudServiceRevoked: // user has revoked permission to use this cloud service
                return alertWithTitle("Purchase failed", message: "Cloud service was revoked")
            }
        }
    }
    func alertWithTitle(_ title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .cancel, handler: nil))
        return alert
    }
    
    func verifyReceipt(completion: @escaping (VerifyReceiptResult) -> Void) {
        let appleValidator = AppleReceiptValidator(service: .production)
        let password = "0c24952dcdf0473fa2ce7763f022a95c"
        SwiftyStoreKit.verifyReceipt(using: appleValidator, password: password, completion: completion)
    }
    // 二次验证
    func verifyPurchase() {
        
        verifyReceipt { result in
            
            switch result {
            case .success(let receipt):
                let productId = self.PRODUCT_Id1
                let purchaseResult = SwiftyStoreKit.verifyPurchase(
                    productId: productId,
                    inReceipt: receipt
                )
                self.alertForVerifyPurchase(purchaseResult)
            case .error:
                self.showAlert(self.alertForVerifyReceipt(result))
                print("eerror")
                break
            }
        }
    }
    
    func alertForVerifyPurchase(_ result: VerifyPurchaseResult){
        
        switch result {
        case .purchased:
            print("Product is purchased")
//            return alertWithTitle("Product is purchased", message: "Product will not expire")
            let ndate = Date()
            nowGlobalSet?.vipDate = ndate as NSDate
            nowGlobalSet?.vipsjc = Int64(ndate.timeIntervalSince1970)
            nowGlobalSet?.isVIP = true
            appDelegate.saveContext()
        case .notPurchased:
            print("This product has never been purchased")
//            return alertWithTitle("Not purchased", message: "This product has never been purchased")
            print("This product has never been purchased")
            nowGlobalSet?.vipsjc = 0
            nowGlobalSet?.isVIP = false
            appDelegate.saveContext()
        }
    }
    
    
    func alertForVerifyReceipt(_ result: VerifyReceiptResult) -> UIAlertController {
        
        switch result {
        case .success(let receipt):
            print("Verify receipt Success: \(receipt)")
            return alertWithTitle("Receipt verified", message: "Receipt verified remotely")
        case .error(let error):
            print("Verify receipt Failed: \(error)")
            switch error {
            case .noReceiptData:
                return alertWithTitle("Receipt verification", message: "No receipt data. Try again.")
            case .networkError(let error):
                return alertWithTitle("Receipt verification", message: "Network error while verifying receipt: \(error)")
            default:
                return alertWithTitle("Receipt verification", message: "Receipt verification failed: \(error)")
            }
        }
    }
    
    // 恢复购买
    func restoreOneMonthPurchase() {
        MobClick.event("WantRestore")
        self.view.makeToastActivity(.center)
        outBuyButton.isUserInteractionEnabled = false
        outRestoreButton.isUserInteractionEnabled = false
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            self.view.hideToastActivity()
            self.outBuyButton.isUserInteractionEnabled = true
            self.outRestoreButton.isUserInteractionEnabled = true
            
            for purchase in results.restoredProducts where purchase.needsFinishTransaction {
                // Deliver content from server, then:
                SwiftyStoreKit.finishTransaction(purchase.transaction)
            }
            
//            self.showAlert(self.alertForRestorePurchases(results))
            
            if let alert = self.alertForRestorePurchases(results) {
                self.showAlert(alert)
            }
        }
    }
    func alertForRestorePurchases(_ results: RestoreResults) -> UIAlertController? {
        
        if results.restoreFailedProducts.count > 0 {
            print("Restore Failed: \(results.restoreFailedProducts)")
//            return alertWithTitle("Restore failed", message: "Unknown error. Please contact support")
            delVip()
            return alertWithTitle("恢复失败", message: "无法连接到 iTunes Store")
        } else if results.restoredProducts.count > 0 {
            print("Restore Success: \(results.restoredProducts)")
//            return alertWithTitle("Purchases Restored", message: "All purchases have been restored")
            
            verifyPurchase()
            
            TipsSwift.showCenterWithText("成功恢复购买", duration: 5)
//            return alertWithTitle("已恢复", message: "成功恢复购买")
            return nil
        } else {
            print("Nothing to Restore")
//            return alertWithTitle("Nothing to restore", message: "No previous purchases were found")
            delVip()
            return alertWithTitle("没有购买过", message: "没有购买过解锁服务")
        }
    }
    
    func delVip() {
        nowGlobalSet?.vipsjc = 0
        nowGlobalSet?.isVIP = false
        appDelegate.saveContext()
    }
    
}

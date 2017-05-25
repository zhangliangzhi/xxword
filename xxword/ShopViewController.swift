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
    var rootv: UIView!
    var outBuyButton:UIButton!
    var outRestoreButton:BootstrapBtn!
    var webv:UIWebView!
    var outTkysButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = BG1_COLOR
        self.navigationItem.title = "商店"
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
        labelDescVip.text = "非会员只能学习前100个单词。\n非会员单词考试无法参加排行榜。\n购买会员可无限制使用。"
        labelDescVip.textColor = WZ1_COLOR
        labelDescVip.numberOfLines = 0
        
        // 条款和隐私政策
        outTkysButton = UIButton(type: .system)
        rootv.addSubview(outTkysButton)
        outTkysButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(rootv)
            make.bottom.equalTo(rootv).offset(-5)
        }
        outTkysButton.setTitle("条款和隐私政策", for: .normal)
        outTkysButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        outTkysButton.addTarget(self, action: #selector(callbackTkys), for: .touchUpInside)
        
        
        // 购买
        outBuyButton =  BootstrapBtn(frame: CGRect(x: 0, y: 0, width: 50, height: 30), btButtonType: .Warning)
        rootv.addSubview(outBuyButton)
        outBuyButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(rootv)
            make.centerY.equalTo(rootv).offset(-60)
            make.width.equalTo(rootv).multipliedBy(0.618)
            make.height.equalTo(68)
        }
        outBuyButton.setTitle("￥30.00", for: .normal)
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
        outLabelKF.text = "订购会员VIP, 无限制使用\n\n月度"
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
        outLabelAuto.text = "自动续期"
        outLabelAuto.textColor = WZ2_COLOR
        outLabelAuto.font = UIFont.systemFont(ofSize: 13)
        
        // 订购说明
        let descBtn = UIButton(type: .system)
        rootv.addSubview(descBtn)
        descBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(outLabelAuto)
            make.left.equalTo(outLabelAuto.snp.right).offset(15)
        }
        descBtn.setTitle("订购说明", for: .normal)
        descBtn.addTarget(self, action: #selector(callbackDesc), for: .touchUpInside)
        descBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
    }
    
    func callbackDesc() {
        let txt = "- 会员功能: 无限使用[象形单词]\n- 订阅期限: 1个月\n- 订购价格: 30元\n- 确认购买时将向iTunes帐户收取付款\n- 本期结束前24小时内收取续费费用\n- 订阅将自动更新，除非在本期结束前至少24小时关闭自动续订\n"

        let alert = UIAlertController(title: "月度会员", message: txt, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func callbackTkys() {
        if webv != nil {
            
            if webv.isHidden {
                webv.isHidden = false
                
                outTkysButton.setTitle("关闭隐私政策", for: .normal)
            }else{
                webv.isHidden = true
                outTkysButton.setTitle("条款和隐私政策", for: .normal)
            }
            return
        }
        webv = UIWebView()
        rootv.addSubview(webv)
        webv.snp.makeConstraints { (make) in
            make.width.equalTo(rootv)
            make.bottom.equalTo(rootv).offset(-30)
            make.top.equalTo(rootv)
        }
        let url = URLRequest(url: URL(string: ysUrl)!)
        webv.loadRequest(url)
        outTkysButton.setTitle("关闭隐私政策", for: .normal)
    }
    
    func reqShop()  {
        SwiftyStoreKit.retrieveProductsInfo(["xxwordHY"]) { result in
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
        
        TipsSwift.showTopWithText("你可以随时取消:\niTunes设置-> 查看Apple ID-> 管理", topOffset: 80, duration: 3)
        self.view.makeToastActivity(.center)
        outBuyButton.isUserInteractionEnabled = false
        outRestoreButton.isUserInteractionEnabled = false
        SwiftyStoreKit.purchaseProduct("xxwordHY", atomically: true) { result in
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
            return alertWithTitle("🎉恭喜🎉", message: "已成为[象形单词]VIP会员")
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
                let productId = "xxwordHY"
                let purchaseResult = SwiftyStoreKit.verifySubscription(
                    type: .autoRenewable,
                    productId: productId,
                    inReceipt: receipt,
                    validUntil: Date()
                )
                self.showAlert(self.alertForVerifySubscription(purchaseResult))
            case .error:
                self.showAlert(self.alertForVerifyReceipt(result))
            }
        }
    }
    func alertForVerifySubscription(_ result: VerifySubscriptionResult) -> UIAlertController {
        
        switch result {
        case .purchased(let expiryDate):
            print("Product is valid until \(expiryDate)")
            nowGlobalSet?.vipDate = expiryDate as NSDate
            nowGlobalSet?.vipsjc = Int64(expiryDate.timeIntervalSince1970)
            nowGlobalSet?.isVIP = true
            appDelegate.saveContext()
//            return alertWithTitle("Product is purchased", message: "Product is valid until \(expiryDate)")
            return alertWithTitle("🎉恭喜🎉", message: "已成为[象形单词]VIP会员")
        case .expired(let expiryDate):
            print("Product is expired since \(expiryDate)")
            nowGlobalSet?.vipsjc = 0
            nowGlobalSet?.isVIP = false
            appDelegate.saveContext()
//            return alertWithTitle("Product expired", message: "Product is expired since \(expiryDate)")
            let formatter = DateFormatter()
            formatter.timeZone = NSTimeZone.system
            formatter.dateFormat = "yyyy-MM-dd hh:mm"
            let dstr:String = formatter.string(from: expiryDate)
            let txt:String = "最近购买时间为: " + dstr
//            lastBuyStr = txt
            return alertWithTitle("会员过期", message: txt)
        case .notPurchased:
            print("This product has never been purchased")
            nowGlobalSet?.vipsjc = 0
            nowGlobalSet?.isVIP = false
            appDelegate.saveContext()
//            return alertWithTitle("Not purchased", message: "This product has never been purchased")
            return alertWithTitle("没有购买", message: "没有购买过会员VIP")
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
            return alertWithTitle("没有购买过", message: "没有购买过会员VIP服务")
        }
    }
    
    func delVip() {
        nowGlobalSet?.vipsjc = 0
        nowGlobalSet?.isVIP = false
        appDelegate.saveContext()
    }
    
}

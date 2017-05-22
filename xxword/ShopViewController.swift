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
    
    func initUI() {
        outBuyButton = BootstrapBtn(frame: CGRect(x: 0, y: 0, width: 50, height: 30), btButtonType: .Warning)
        self.view.addSubview(outBuyButton)
        outBuyButton.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.8)
            make.height.equalTo(60)
        }
        outBuyButton.setTitle("🛒月会员VIP \n￥30.00", for: .normal)
        outBuyButton.titleLabel?.numberOfLines = 0
        outBuyButton.titleLabel?.textAlignment = .center
        outBuyButton.addTarget(self, action: #selector(buyOneMonthPurchase), for: .touchUpInside)
        
        let labelDescVip = UILabel()
        self.view.addSubview(labelDescVip)
        labelDescVip.snp.makeConstraints { (make) in
            make.bottom.equalTo(outBuyButton.snp.top).offset(-30)
            make.centerX.equalTo(self.view)
            make.width.equalTo(self.view).multipliedBy(0.8)
        }
        labelDescVip.textAlignment = .center
        labelDescVip.text = "购买VIP会员服务, \n可无限制使用[象形单词]"
        labelDescVip.textColor = WZ1_COLOR
        labelDescVip.numberOfLines = 0
        
    }
    
    func reqShop()  {
        SwiftyStoreKit.retrieveProductsInfo(["xxwordHY"]) { result in
            if let product = result.retrievedProducts.first {
                let priceString = product.localizedPrice!
                
                print("Product title: \(product.localizedTitle), price: \(priceString)")
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
        print("buy one click")
        self.view.makeToastActivity(.center)
        outBuyButton.isUserInteractionEnabled = false
        SwiftyStoreKit.purchaseProduct("xxwordHY", atomically: true) { result in
            self.view.hideToastActivity()
            self.outBuyButton.isUserInteractionEnabled = true
            if case .success(let purchase) = result {
                // Deliver content from server, then:
                if purchase.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(purchase.transaction)
                }
            }
            if let alert = self.alertForPurchaseResult(result) {
                print(alert)
                
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
            return alertWithTitle("🎉恭喜🎉", message: "已成为[象形单词]VIP会员")
        case .error(let error):
            print("Purchase Failed: \(error)")
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
            nowGlobalSet?.vipsjc = Int32(expiryDate.timeIntervalSince1970)
            nowGlobalSet?.isVIP = true
            appDelegate.saveContext()
//            return alertWithTitle("Product is purchased", message: "Product is valid until \(expiryDate)")
            return alertWithTitle("🎉恭喜🎉", message: "已成为[象形单词]VIP会员")
        case .expired(let expiryDate):
            print("Product is expired since \(expiryDate)")
            nowGlobalSet?.vipsjc = 0
            nowGlobalSet?.isVIP = false
            appDelegate.saveContext()
            return alertWithTitle("Product expired", message: "Product is expired since \(expiryDate)")
        case .notPurchased:
            print("This product has never been purchased")
            nowGlobalSet?.vipsjc = 0
            nowGlobalSet?.isVIP = false
            appDelegate.saveContext()
            return alertWithTitle("Not purchased", message: "This product has never been purchased")
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
    
    func restoreOneMonthPurchase() {
    }
    
    
}

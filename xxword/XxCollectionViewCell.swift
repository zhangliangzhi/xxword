//
//  XxCollectionViewCell.swift
//  xxword
//
//  Created by ZhangLiangZhi on 2017/5/5.
//  Copyright © 2017年 xigk. All rights reserved.
//

import UIKit
import SnapKit

class XxCollectionViewCell: UICollectionViewCell {
    
    var centerLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        var bgv = UIView()
        self.addSubview(bgv)
        bgv.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.height.equalTo(self)
        }
        bgv.backgroundColor = UIColor.gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

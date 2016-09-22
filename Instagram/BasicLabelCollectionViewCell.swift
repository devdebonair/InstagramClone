//
//  BasicLabelCollectionViewCell.swift
//  Instagram
//
//  Created by Vincent Moore on 6/7/16.
//  Copyright © 2016 Vincent Moore. All rights reserved.
//

import UIKit

class BasicLabelCollectionViewCell: UICollectionViewCell {
    
    static let IDENTIFIER = "BASIC_LABEL_COLLECTION_CELL"
    
    internal var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(12)
            make.right.equalTo(contentView).offset(-30)
            make.top.equalTo(contentView).offset(6)
            make.bottom.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

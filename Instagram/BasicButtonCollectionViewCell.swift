//
//  BasicButtonCollectionViewCell.swift
//  Instagram
//
//  Created by Vincent Moore on 6/7/16.
//  Copyright © 2016 Vincent Moore. All rights reserved.
//

import UIKit

class BasicButtonCollectionViewCell: UICollectionViewCell {
 
    static let IDENTIFIER = "BASIC_BUTTON_COLLECTION_CELL"
    
    internal var button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(button)
        
        button.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(12)
            make.top.equalTo(contentView)
            make.bottom.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

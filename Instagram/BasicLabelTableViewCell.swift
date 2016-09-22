//
//  BasicLabelTableViewCell.swift
//  Instagram
//
//  Created by Vincent Moore on 5/30/16.
//  Copyright © 2016 Vincent Moore. All rights reserved.
//

import UIKit
import SnapKit

class BasicLabelTableViewCell: UITableViewCell {

    static let IDENTIFIER = "BASIC_LABEL_CELL"
    
    internal var label = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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

//
//  BasicButtonTableViewCell.swift
//  Instagram
//
//  Created by Vincent Moore on 5/30/16.
//  Copyright © 2016 Vincent Moore. All rights reserved.
//

import UIKit
import SnapKit

class BasicButtonTableViewCell: UITableViewCell {

    static let IDENTIFIER = "BASIC_BUTTON_CELL"
    
    internal var button = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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

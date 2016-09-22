//
//  ActionCollectionViewCell.swift
//  Instagram
//
//  Created by Vincent Moore on 6/8/16.
//  Copyright © 2016 Vincent Moore. All rights reserved.
//

import UIKit

class ActionCollectionViewCell: UICollectionViewCell {
 
    static let IDENTIFIER = "ACTION_COLLECTION_CELL"
    
    internal var buttonLike: UIButton
    internal var buttonReply: UIButton
    internal var buttonComment: UIButton
    internal var stackViewContainer: UIStackView
    internal var stackViewActions: UIStackView
    
    override init(frame: CGRect) {
        
        buttonLike = UIButton(type: .system)
        buttonReply = UIButton(type: .system)
        buttonComment = UIButton(type: .system)
        stackViewContainer = UIStackView()
        stackViewActions = UIStackView()
        
        super.init(frame: frame)
        
        let marginsStackView: CGFloat = 5
        
        buttonLike.translatesAutoresizingMaskIntoConstraints = false
        buttonReply.translatesAutoresizingMaskIntoConstraints = false
        buttonComment.translatesAutoresizingMaskIntoConstraints = false
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let imageLike = UIImage(named: IMAGE_ACTIVITY_NAME)
        let imageReply = UIImage(named: IMAGE_REPLY_NAME)
        let imageComment = UIImage(named: IMAGE_COMMENT_NAME)
        
        if let imageLike = imageLike, let imageReply = imageReply, let imageComment = imageComment {
            buttonLike.setBackgroundImage(imageLike, for: UIControlState())
            buttonReply.setBackgroundImage(imageReply, for: UIControlState())
            buttonComment.setBackgroundImage(imageComment, for: UIControlState())
            
            buttonLike.tintColor = UIColor.darkText
            buttonReply.tintColor = UIColor.darkText
            buttonComment.tintColor = UIColor.darkText
        } else {
            buttonLike.setTitle(TITLE_LIKE, for: UIControlState())
            buttonReply.setTitle(TITLE_REPLY, for: UIControlState())
            buttonComment.setTitle(TITLE_COMMENT, for: UIControlState())
            
            buttonLike.setTitleColor(UIColor.darkText, for: UIControlState())
            buttonReply.setTitleColor(UIColor.darkText, for: UIControlState())
            buttonComment.setTitleColor(UIColor.darkText, for: UIControlState())
            
            buttonLike.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.footnote)
            buttonComment.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.footnote)
            buttonReply.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.footnote)
        }
        
        stackViewContainer.axis = .horizontal
        stackViewContainer.spacing = 24
        
        stackViewContainer.addArrangedSubview(buttonLike)
        stackViewContainer.addArrangedSubview(buttonComment)
        stackViewContainer.addArrangedSubview(buttonReply)
        
        contentView.addSubview(stackViewContainer)
        
        buttonLike.snp.makeConstraints { (make) in
            make.height.equalTo(24).priority(750)
            make.width.equalTo(28).priority(750)
        }
        
        buttonReply.snp.makeConstraints { (make) in
            make.size.equalTo(24).priority(750)
        }
        
        buttonComment.snp.makeConstraints { (make) in
            make.height.equalTo(24).priority(750)
            make.width.equalTo(28).priority(750)
        }
        
        stackViewContainer.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(marginsStackView + 5)
            make.left.equalTo(contentView).offset(12)
            make.bottom.equalTo(contentView).offset(-marginsStackView - 5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

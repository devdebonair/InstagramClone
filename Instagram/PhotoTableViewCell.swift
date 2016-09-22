//
//  PhotoTableViewCell.swift
//  Instagram
//
//  Created by Vincent Moore on 5/28/16.
//  Copyright © 2016 Vincent Moore. All rights reserved.
//

import UIKit
import SnapKit

class PhotoTableViewCell: UITableViewCell {

    static let IDENTIFIER = "PHOTO_CELL"
    
    internal var imagePhoto = UIImageView()
    internal var stackViewContainer = UIStackView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        imagePhoto.translatesAutoresizingMaskIntoConstraints = false

        imagePhoto.contentMode = .scaleAspectFit
        
        contentView.addSubview(stackViewContainer)
        stackViewContainer.addArrangedSubview(imagePhoto)
        
        stackViewContainer.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        
        imagePhoto.snp.makeConstraints { (make) in
            make.left.right.equalTo(stackViewContainer)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPhotoHeight(_ height: CGFloat) {
        imagePhoto.snp.remakeConstraints { (make) in
            make.height.equalTo(height).priority(750)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imagePhoto.image = nil
    }
    
}

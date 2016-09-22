//
//  PhotoCollectionViewCell.swift
//  Instagram
//
//  Created by Vincent Moore on 6/3/16.
//  Copyright © 2016 Vincent Moore. All rights reserved.
//

import UIKit
import SnapKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let IDENTIFIER = "PHOTO_COLLECTION_CELL"
    
    internal var imagePhoto = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imagePhoto.contentMode = .scaleAspectFit
        
        contentView.addSubview(imagePhoto)
        
        imagePhoto.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPhotoHeight(_ height: CGFloat) {
        imagePhoto.snp.makeConstraints { (make) in
            make.height.equalTo(height)
        }
    }
    
}

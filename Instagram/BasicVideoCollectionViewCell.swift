//
//  BasicVideoCollectionViewCell.swift
//  Instagram
//
//  Created by Vincent Moore on 6/7/16.
//  Copyright © 2016 Vincent Moore. All rights reserved.
//

import UIKit
import SnapKit

class BasicVideoCollectionViewCell: UICollectionViewCell {
    
    static let IDENTIFIER = "BASIC_VIDEO_COLLECTION_CELL"
    
    internal var player: VideoPlayer
    internal var posterImage: UIImageView
    
    override init(frame: CGRect) {
        player = VideoPlayer(frame: frame)
        posterImage = UIImageView(frame: frame)
        
        super.init(frame: frame)
        
        player.alpha = 0.0
        player.onReadyToPlay = {
            UIView.animate(withDuration: 0.5, animations: {
                self.posterImage.alpha = 0.0
                self.player.alpha = 1.0
                }, completion: { (success: Bool) in
                    self.posterImage.alpha = 0.0
                    self.player.alpha = 1.0
            })
        }
        
        posterImage.contentMode = .scaleAspectFit
        
        contentView.addSubview(player)
        contentView.addSubview(posterImage)
        
        player.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        
        posterImage.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
    }
    
    func setMediaHeight(_ height: CGFloat) {
        player.snp.makeConstraints({ (make) in
            make.height.equalTo(height).priority(750)
        })
        posterImage.snp.makeConstraints { (make) in
            make.height.equalTo(height).priority(750)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        player.clean()
        player.alpha = 0.0
        posterImage.alpha = 1.0
        posterImage.image = nil
    }

}

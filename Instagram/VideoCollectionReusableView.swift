//
//  VideoCollectionReusableView.swift
//  Instagram
//
//  Created by Vincent Moore on 6/4/16.
//  Copyright © 2016 Vincent Moore. All rights reserved.
//

import UIKit
import SnapKit

class VideoCollectionReusableView: UICollectionReusableView {
    
    static let IDENTIFIER = "VIDEO_REUSABLE_VIEW"
    
    internal var player: VideoPlayer
    internal var labelHeader: UILabel
    internal var labelDescription: UILabel
    internal var stackViewLabels: UIStackView
    internal var stackViewContainer: UIStackView
    internal var imagePlay: UIImageView
    internal var posterImage: UIImageView
    
    override init(frame: CGRect) {
        player = VideoPlayer(frame: frame)
        posterImage = UIImageView(frame: frame)
        labelHeader = UILabel()
        labelDescription = UILabel()
        imagePlay = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        
        let stackViewHeight = frame.height / 6
        stackViewLabels = UIStackView()
        stackViewContainer = UIStackView(frame: CGRect(x: 10, y: frame.height - stackViewHeight - 10, width: frame.width, height: stackViewHeight))
        
        super.init(frame: frame)
        
        player.autoplay = true
        player.onReadyToPlay = {
            UIView.animate(withDuration: 0.5, animations: {
                self.posterImage.alpha = 0.0
                self.player.alpha = 1.0
                }, completion: { (success: Bool) in
                    self.posterImage.alpha = 0.0
                    self.player.alpha = 1.0
            })
        }
        
        imagePlay.image = UIImage(named: "play")
        imagePlay.tintColor = UIColor.white
        imagePlay.translatesAutoresizingMaskIntoConstraints = false
        
        posterImage.contentMode = .scaleAspectFit
        
        labelHeader.text = "WATCH"
        labelHeader.font = UIFont.boldSystemFont(ofSize: 12)
        labelHeader.textColor = UIColor.white.withAlphaComponent(0.5)
        
        labelDescription.text = "Music Videos"
        labelDescription.textColor = UIColor.white
        labelDescription.font = UIFont.boldSystemFont(ofSize: 18)
        
        stackViewLabels.axis = .vertical
        stackViewLabels.addArrangedSubview(labelHeader)
        stackViewLabels.addArrangedSubview(labelDescription)
        
        stackViewContainer.axis = .horizontal
        stackViewContainer.spacing = 10
        stackViewContainer.addArrangedSubview(imagePlay)
        stackViewContainer.addArrangedSubview(stackViewLabels)
        
        addSubview(player)
        addSubview(posterImage)
        addSubview(stackViewContainer)
    }
    
    override func layoutSubviews() {
        player.frame = frame
        posterImage.frame = frame
        let stackViewHeight = frame.height / 4
        stackViewContainer = UIStackView(frame: CGRect(x: 10, y: frame.height - stackViewHeight - 10, width: frame.width, height: stackViewHeight))
        imagePlay.frame.size = CGSize(width: 20, height: 20)
        imagePlay.snp.remakeConstraints { (make) in
            make.size.equalTo(35).priority(999)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        player.clean()
        posterImage.alpha = 1.0
        posterImage.image = nil
    }

}

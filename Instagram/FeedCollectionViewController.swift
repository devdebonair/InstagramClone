//
//  FeedCollectionViewController.swift
//  Instagram
//
//  Created by Vincent Moore on 6/7/16.
//  Copyright © 2016 Vincent Moore. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FeedCollectionViewController: UICollectionViewController {

    fileprivate enum CellType: Int {
        case photo = 0
        case action = 1
        case likes = 2
        case caption = 3
        case moreComments = 4
        case commentOne = 5
        case commentTwo = 6
        case date = 7
    }
    
    let HEADER_VIEW_HEIGHT: CGFloat = 60
    let SIZE_FONT_POST_DETAILS: CGFloat = 14
    let NUMBER_OF_DETAILS = 8
    
    let photoWidth = 612
    let photoHeight = 612
    
    let videoHeight = 1080
    let videoWidth = 1920
    
    let barItemDirectMessage = UIBarButtonItem()
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = barItemDirectMessage
        
        let imageLogo = UIImage(named: IMAGE_LOGO_NAME)
        navigationItem.titleView = UIImageView(image: imageLogo)
        
        let imageDirectMessage = UIImage(named: IMAGE_MAIL_NAME)
        if let imageDirectMessage = imageDirectMessage {
            barItemDirectMessage.image = imageDirectMessage
        } else {
            barItemDirectMessage.title = TITLE_DIRECT_MESSAGING
        }
        
    
        collectionView!.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.IDENTIFIER)
        collectionView!.register(ActionCollectionViewCell.self, forCellWithReuseIdentifier: ActionCollectionViewCell.IDENTIFIER)
        collectionView!.register(BasicLabelCollectionViewCell.self, forCellWithReuseIdentifier: BasicLabelCollectionViewCell.IDENTIFIER)
        collectionView!.register(BasicButtonCollectionViewCell.self, forCellWithReuseIdentifier: BasicButtonCollectionViewCell.IDENTIFIER)
        collectionView!.register(BasicVideoCollectionViewCell.self, forCellWithReuseIdentifier: BasicVideoCollectionViewCell.IDENTIFIER)
        collectionView!.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "stizzuff")
        
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = CGSize(width: collectionView!.frame.width, height: 120)
            layout.headerReferenceSize = CGSize(width: collectionView!.frame.width, height: HEADER_VIEW_HEIGHT)
        }
        
        navigationController?.hidesBarsOnSwipe = true
        automaticallyAdjustsScrollViewInsets = false
        extendedLayoutIncludesOpaqueBars = true
        edgesForExtendedLayout = UIRectEdge()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 50
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NUMBER_OF_DETAILS
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let fontDetail = UIFont.systemFont(ofSize: SIZE_FONT_POST_DETAILS)
        let fontDetailBold = UIFont.boldSystemFont(ofSize: SIZE_FONT_POST_DETAILS - 0.5)
        
        let getAttributes: (_ username: String, _ text: String) -> NSMutableAttributedString = { username, text in
            let comment = "\(username) \(text)"
            let attributedString = NSMutableAttributedString(string: comment)
            do {
                let regex = try NSRegularExpression(pattern: "[#@]\\S+\\b", options: [])
                regex.enumerateMatches(in: comment, options: [], range: NSRange(location: 0, length: comment.characters.count), using: { (match: NSTextCheckingResult?, flags: NSRegularExpression.MatchingFlags, stop: UnsafeMutablePointer<ObjCBool>) in
                    let matchRange = match?.rangeAt(0)
                    if let matchRange = matchRange {
                        let color = COLOR_TEXT_HIGHLIGHT
                        attributedString.addAttribute(NSForegroundColorAttributeName, value: color, range: matchRange)
                    }
                })
            } catch {}
            attributedString.addAttribute(NSFontAttributeName, value: fontDetailBold, range: NSRange(location: 0, length: username.characters.count))
            return attributedString
        }
        
        var identifier: String
        
        if (indexPath as NSIndexPath).row == CellType.photo.rawValue && (indexPath as NSIndexPath).section % 2 == 0{
            identifier = PhotoCollectionViewCell.IDENTIFIER
        } else if (indexPath as NSIndexPath).row == CellType.photo.rawValue && (indexPath as NSIndexPath).section % 2 != 0 {
            identifier = BasicVideoCollectionViewCell.IDENTIFIER
        } else if (indexPath as NSIndexPath).row == CellType.action.rawValue {
            identifier = ActionCollectionViewCell.IDENTIFIER
        } else if (indexPath as NSIndexPath).row == CellType.moreComments.rawValue {
            identifier = BasicButtonCollectionViewCell.IDENTIFIER
        } else {
            identifier = BasicLabelCollectionViewCell.IDENTIFIER
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
        
        let videoUrl = "http://vevoplaylist-live.hls.adaptive.level3.net/vevo/ch1/appleman.m3u8"
        if let cell = cell as? BasicVideoCollectionViewCell {
            let newHeight = aspectHeight(UIScreen.main.bounds.size, CGSize(width: videoWidth, height: videoHeight))
            cell.posterImage.kf.setImage(with: URL(string: "http://www.vexradio.com/wp-content/uploads/2016/04/rihanna-twerked-all-over-drake-last-night-in-toronto-youtube-thumbnail.jpg")!)
            cell.setMediaHeight(newHeight)
            cell.player.url = videoUrl
            cell.player.autoplay = true
        }
        
        let urlStuff = "http://media1.popsugar-assets.com/files/2014/04/22/038/n/4852708/1e2c8a399e0e249a_927904_1483961288493218_190657696_n.xxxlarge/i/Get-Social-Media.jpg"
        if let cell = cell as? PhotoCollectionViewCell, let url = URL(string: urlStuff) {
            let newHeight = aspectHeight(UIScreen.main.bounds.size, CGSize(width: photoWidth, height: photoHeight))
            cell.setPhotoHeight(newHeight)
            cell.imagePhoto.kf.setImage(with: url)
        }
        
        if let cell = cell as? ActionCollectionViewCell {
            cell.buttonLike.tintColor = COLOR_TEXT
            cell.buttonReply.tintColor = COLOR_TEXT
            cell.buttonComment.tintColor = COLOR_TEXT
        }
        
        if let cell = cell as? BasicButtonCollectionViewCell {
            cell.button.setTitle("View all 4 comments", for: UIControlState())
            cell.button.setTitleColor(COLOR_TEXT_ACCENT, for: UIControlState())
            cell.button.titleLabel?.font = fontDetail
        }
        
        if let cell = cell as? BasicLabelCollectionViewCell {
            cell.label.font  = fontDetail
            cell.label.textColor = COLOR_TEXT
            cell.label.numberOfLines = 0
            
            if (indexPath as NSIndexPath).row == CellType.likes.rawValue {
                cell.label.text = "❤️ 1,738 likes"
                cell.label.font = fontDetailBold
            }
            
            if (indexPath as NSIndexPath).row == CellType.caption.rawValue {
                let username = "margotrobbie"
                let text = "Finally joined Instagram @margotrobbie #peerpressurepaysoff"
                cell.label.attributedText = getAttributes(username, text)
            }
            
            if (indexPath as NSIndexPath).row == CellType.commentOne.rawValue {
                let username = "md_halli"
                let text = "You rarely upload photos. More photos please:)"
                cell.label.attributedText = getAttributes(username, text)
            }
            
            if (indexPath as NSIndexPath).row == CellType.commentTwo.rawValue {
                let username = "mahan_zn"
                let text = "Inja hanooz salem boode"
                cell.label.attributedText = getAttributes(username, text)
            }
            
            if (indexPath as NSIndexPath).row == CellType.date.rawValue {
                cell.label.text = "1 HOUR AGO"
                cell.label.font  = UIFont.systemFont(ofSize: 10)
                cell.label.textColor = COLOR_TEXT_ACCENT
            }
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        if let cell = cell as? BasicVideoCollectionViewCell {
            cell.player.toggleVolume()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "stizzuff", for: indexPath)
        let urlStuff = "https://scontent-atl3-1.cdninstagram.com/t51.2885-19/12751240_847720175337515_582920588_a.jpg"
        let AVATAR_SIZE: CGFloat = 28
        let OFFSET_CONTENT: CGFloat = 10
        
        let stackViewContainer = UIStackView()
        let stackViewUserDetails = UIStackView()
        let imageAvatar = UIImageView()
        let imageMore = UIImageView(image: UIImage(named: "more"))
        let labelAvatarName = UILabel()
        
        imageAvatar.translatesAutoresizingMaskIntoConstraints = false
        imageMore.translatesAutoresizingMaskIntoConstraints = false
        labelAvatarName.translatesAutoresizingMaskIntoConstraints = false
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.backgroundColor = COLOR_BACKGROUND
        
        labelAvatarName.text = "margotrobbie"
        labelAvatarName.font = UIFont.boldSystemFont(ofSize: SIZE_FONT_POST_DETAILS - 1)
        labelAvatarName.textColor = COLOR_TEXT
        
        stackViewContainer.axis = .horizontal
        stackViewContainer.distribution = .fillProportionally
        stackViewContainer.alignment = .center
        
        stackViewUserDetails.spacing = OFFSET_CONTENT
        
        imageAvatar.kf.setImage(with: URL(string: urlStuff)!)
        imageAvatar.contentMode = .scaleAspectFill
        imageAvatar.layer.cornerRadius = AVATAR_SIZE / 2
        imageAvatar.clipsToBounds = true
        
        imageMore.tintColor = COLOR_TEXT
        
        imageAvatar.snp.makeConstraints { (make) in
            make.size.equalTo(AVATAR_SIZE)
        }
        
        imageMore.snp.makeConstraints { (make) in
            make.height.equalTo(3)
            make.width.equalTo(13)
        }
        
        stackViewUserDetails.addArrangedSubview(imageAvatar)
        stackViewUserDetails.addArrangedSubview(labelAvatarName)
        stackViewContainer.addArrangedSubview(stackViewUserDetails)
        stackViewContainer.addArrangedSubview(imageMore)
        
        let borderColor = COLOR_USER_HEADER_BORDER
        headerView.addBorder(edges: .bottom, colour: borderColor, thickness: 0.3)
        
        headerView.addSubview(stackViewContainer)
        
        stackViewContainer.snp.remakeConstraints { (make) in
            make.top.left.equalTo(headerView).offset(OFFSET_CONTENT)
            make.bottom.right.equalTo(headerView).offset(-OFFSET_CONTENT)
        }
        return headerView
    }
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? BasicVideoCollectionViewCell {
            cell.player.mute()
        }
    }
}

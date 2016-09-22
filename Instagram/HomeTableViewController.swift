//
//  ViewController.swift
//  Instagram
//
//  Created by Vincent Moore on 5/28/16.
//  Copyright © 2016 Vincent Moore. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

class HomeTableViewController: UITableViewController {
    
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
    
    let videoHeight = 640
    let videoWidth = 640
    
    let barItemDirectMessage = UIBarButtonItem()
    
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
        
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.IDENTIFIER)
        tableView.register(ActionTableViewCell.self, forCellReuseIdentifier: ActionTableViewCell.IDENTIFIER)
        tableView.register(BasicLabelTableViewCell.self, forCellReuseIdentifier: BasicLabelTableViewCell.IDENTIFIER)
        tableView.register(BasicButtonTableViewCell.self, forCellReuseIdentifier: BasicButtonTableViewCell.IDENTIFIER)
        tableView.register(VideoTableViewCell.self, forCellReuseIdentifier: VideoTableViewCell.IDENTIFIER)
        
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.cellLayoutMarginsFollowReadableWidth = false
        tableView.backgroundColor = COLOR_BACKGROUND
        
        navigationController?.hidesBarsOnSwipe = true
        automaticallyAdjustsScrollViewInsets = false
        extendedLayoutIncludesOpaqueBars = true
        edgesForExtendedLayout = UIRectEdge()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let cells = tableView.visibleCells
        for cell in cells {
            if let cell = cell as? VideoTableViewCell {
                cell.videoPlayer.pause()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
        
        var identifier: String!
        
        if (indexPath as NSIndexPath).row == CellType.photo.rawValue && (indexPath as NSIndexPath).section % 2 == 0{
            identifier = PhotoTableViewCell.IDENTIFIER
        } else if (indexPath as NSIndexPath).row == CellType.photo.rawValue && (indexPath as NSIndexPath).section % 2 != 0 {
            identifier = VideoTableViewCell.IDENTIFIER
        } else if (indexPath as NSIndexPath).row == CellType.action.rawValue {
            identifier = ActionTableViewCell.IDENTIFIER
        } else if (indexPath as NSIndexPath).row == CellType.moreComments.rawValue {
            identifier = BasicButtonTableViewCell.IDENTIFIER
        } else {
            identifier = BasicLabelTableViewCell.IDENTIFIER
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        cell.selectionStyle = .none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
        
        if !cell.isKind(of: ActionTableViewCell.self) {
            cell.separatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: tableView.frame.width)
        }
        
        let videoUrl = "https://scontent-atl3-1.cdninstagram.com/t50.2886-16/14130422_153846261723391_110135710_n.mp4"
        if let cell = cell as? VideoTableViewCell {
            let newHeight = aspectHeight(UIScreen.main.bounds.size, CGSize(width: videoWidth, height: videoHeight))
            cell.posterImage.kf.setImage(with: URL(string: "https://scontent-atl3-1.cdninstagram.com/t51.2885-15/s640x640/e15/14033019_1720325431551782_1535927566_n.jpg")!)
            cell.setMediaHeight(newHeight)
            cell.videoPlayer.url = videoUrl
            cell.videoPlayer.autoplay = true
        }
        
        let urlStuff = "http://media1.popsugar-assets.com/files/2014/04/22/038/n/4852708/1e2c8a399e0e249a_927904_1483961288493218_190657696_n.xxxlarge/i/Get-Social-Media.jpg"
        if let cell = cell as? PhotoTableViewCell, let url = URL(string: urlStuff) {
            let newHeight = aspectHeight(UIScreen.main.bounds.size, CGSize(width: photoWidth, height: photoHeight))
            cell.setPhotoHeight(newHeight)
            cell.imagePhoto.kf.setImage(with: url)
        }
        
        if let cell = cell as? ActionTableViewCell {
            cell.buttonLike.tintColor = COLOR_TEXT
            cell.buttonReply.tintColor = COLOR_TEXT
            cell.buttonComment.tintColor = COLOR_TEXT
        }
        
        if let cell = cell as? BasicButtonTableViewCell {
            cell.button.setTitle("View all 4 comments", for: UIControlState())
            cell.button.setTitleColor(COLOR_TEXT_ACCENT, for: UIControlState())
            cell.button.titleLabel?.font = fontDetail
        }
        
        if let cell = cell as? BasicLabelTableViewCell {
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if let cell = cell as? VideoTableViewCell {
            cell.videoPlayer.toggleVolume()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NUMBER_OF_DETAILS
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 15
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let urlStuff = "https://scontent-atl3-1.cdninstagram.com/t51.2885-19/12751240_847720175337515_582920588_a.jpg"
        let AVATAR_SIZE: CGFloat = 28
        let OFFSET_CONTENT: CGFloat = 10
        
        let stackViewContainer = UIStackView()
        let stackViewUserDetails = UIStackView()
        let imageAvatar = UIImageView()
        let imageMore = UIImageView(image: UIImage(named: "more"))
        let labelAvatarName = UILabel()
        let headerView = UIView()
        
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
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? VideoTableViewCell {
            cell.videoPlayer.mute()
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return HEADER_VIEW_HEIGHT
    }

}

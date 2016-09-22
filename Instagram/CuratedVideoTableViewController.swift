//
//  CuratedVideoTableViewController.swift
//  Instagram
//
//  Created by Vincent Moore on 6/5/16.
//  Copyright © 2016 Vincent Moore. All rights reserved.
//

import UIKit

class CuratedVideoTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(VideoTableViewCell.self, forCellReuseIdentifier: VideoTableViewCell.IDENTIFIER)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        tableView.separatorStyle = .none
//        tableView.pagingEnabled = true
        tableView.backgroundColor = UIColor.clear
        view.backgroundColor = UIColor.black
        
        navigationController?.navigationBar.barTintColor = UIColor.clear
        navigationItem.title = "Music Videos"
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            let stuff = aspectHeight(self.tableView.frame.size, CGSize(width: 1920, height: 1080))
            let y = (UIScreen.main.bounds.height / 2) - (stuff / 2)
            self.tableView.contentOffset.y = -y
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.IDENTIFIER, for: indexPath)
        cell.contentView.alpha = 0.25
        cell.backgroundColor = UIColor.clear
        if let cell = cell as? VideoTableViewCell{
            let newHeight = aspectHeight(tableView.frame.size, CGSize(width: 1920, height: 1080))
            cell.setMediaHeight(newHeight)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? VideoTableViewCell {
            cell.posterImage.kf.setImage(with: URL(string: "http://www.vexradio.com/wp-content/uploads/2016/04/rihanna-twerked-all-over-drake-last-night-in-toronto-youtube-thumbnail.jpg")!)
            cell.videoPlayer.url = "http://vevoplaylist-live.hls.adaptive.level3.net/vevo/ch1/appleman.m3u8"
        }
    }
    
//    override func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if !decelerate {
//            self.scrollViewDidEndDecelerating(scrollView)
//        }
//    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let stuff = aspectHeight(tableView.frame.size, CGSize(width: 1920, height: 1080))
        targetContentOffset.pointee.x = tableView.contentOffset.x
        targetContentOffset.pointee.y = tableView.contentOffset.y + stuff
    }
    
//    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
//        let stuff = aspectHeight(sizeToFit: tableView.frame.size, originalSize: CGSize(width: 1920, height: 1080))
//        print(tableView.contentOffset.y + stuff)
//        let indexPath = tableView.indexPathForRowAtPoint(CGPoint(x: 0, y: tableView.center.y + 200))
//        print("Section: \(indexPath?.section) Row: \(indexPath?.row)")
//        if let indexPath = indexPath {
//            tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Middle, animated: true)
//        }
//    }

}

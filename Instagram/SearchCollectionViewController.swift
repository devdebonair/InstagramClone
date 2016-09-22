//
//  SearchCollectionViewController.swift
//  Instagram
//
//  Created by Vincent Moore on 6/3/16.
//  Copyright © 2016 Vincent Moore. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit
import AVFoundation

private let reuseIdentifier = "Cell"

class SearchCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.IDENTIFIER)
        self.collectionView!.register(VideoCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: VideoCollectionReusableView.IDENTIFIER)
        collectionView!.backgroundColor = UIColor.clear
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            let padding: CGFloat = 1
            let numberInRow: CGFloat = 3
            let size = (collectionView!.frame.width / numberInRow) - padding
            layout.itemSize = CGSize(width: size, height: size)
            layout.minimumLineSpacing = padding
            layout.minimumInteritemSpacing = padding
            layout.sectionInset = UIEdgeInsets(top: padding, left: 0, bottom: padding, right: 0)
        }
        
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        let searchField = searchBar.value(forKey: "searchField") as? UITextField
        searchField?.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
        searchField?.textColor = UIColor.lightGray
        searchBar.placeholder = "Search"
        navigationItem.titleView = searchBar
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let headers = collectionView?.visibleSupplementaryViews(ofKind: UICollectionElementKindSectionHeader)
        if let headers = headers {
            for header in headers {
                if let header = header as? VideoCollectionReusableView {
                    header.player.pause()
                }
            }
        }
    }

    func didTapReccomendedVideos(_ recognizer: UITapGestureRecognizer) {
        let controller = CuratedVideoTableViewController()
        controller.navigationItem.title = "Music Videos"
        controller.navigationController?.navigationBar.tintColor = UIColor.white
        let navigationController = UINavigationController(rootViewController: controller)
//        navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
//        navigationController.navigationBar.tintColor = UIColor.whiteColor()
        present(navigationController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.IDENTIFIER, for: indexPath)
        let urlStuff = "http://media1.popsugar-assets.com/files/2014/04/22/038/n/4852708/1e2c8a399e0e249a_927904_1483961288493218_190657696_n.xxxlarge/i/Get-Social-Media.jpg"
        if let cell = cell as? PhotoCollectionViewCell {
            cell.imagePhoto.kf.setImage(with: URL(string: urlStuff)!)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: VideoCollectionReusableView.IDENTIFIER, for: indexPath)
        if let header = header as? VideoCollectionReusableView {
            header.player.url = "http://vevoplaylist-live.hls.adaptive.level3.net/vevo/ch1/appleman.m3u8"
            header.posterImage.kf.setImage(with: URL(string: "http://www.vexradio.com/wp-content/uploads/2016/04/rihanna-twerked-all-over-drake-last-night-in-toronto-youtube-thumbnail.jpg")!)
        }
        header.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.didTapReccomendedVideos(_:))))
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let size = CGSize(width: 1920, height: 1080)
        let newHeight = aspectHeight(collectionView.frame.size, size)
        return CGSize(width: collectionView.frame.width, height: newHeight)
    }

}

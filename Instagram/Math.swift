//
//  Math.swift
//  Instagram
//
//  Created by Vincent Moore on 6/5/16.
//  Copyright © 2016 Vincent Moore. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

let aspectHeight: (_ sizeToFit: CGSize, _ originalSize: CGSize) -> CGFloat = { sizeToFit, originSize in
    let aspectWidth = sizeToFit.width / originSize.width
    let aspectHeight = sizeToFit.height / originSize.height
    let ratio = min(aspectWidth, aspectHeight)
    let newHeight = originSize.height * ratio
    return newHeight
}

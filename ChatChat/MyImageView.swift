//
//  MyImageView.swift
//  ChatChat
//
//  Created by Xin Ding on 5/4/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import Foundation
import UIKit
import Gifu
class MyImageView: UIImageView, GIFAnimatable {
    public lazy var animator: Animator? = {
        return Animator(withDelegate: self)
    }()
    
    override public func display(_ layer: CALayer) {
        updateImageIfNeeded()
    }
}

//
//  UIView+Animation.swift
//  FlickrSlideAlbum
//
//  Created by Tae-moonCho on 2016. 8. 21..
//  Copyright © 2016년 . All rights reserved.
//

import UIKit

public extension UIView {
    func fadeIn(duration: NSTimeInterval = 0.35) {
        UIView.animateWithDuration(duration, animations: {
            self.alpha = 1.0
        })
    }
    
    func fadeOut(duration: NSTimeInterval = 0.35) {
        UIView.animateWithDuration(duration, animations: {
            self.alpha = 0.0
        })
    }
    
    func fadeOutAndIn(duration: NSTimeInterval = 0.7, beforeCompleteBlock: () -> Void) {
        UIView.animateWithDuration(duration / 2, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.alpha = 0.0
            }, completion: { (fadeOutComplete) -> Void in
                beforeCompleteBlock()
                UIView.animateWithDuration(duration / 2, delay: 0.1, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                    self.alpha = 1.0
                    }, completion: {(fadeOutComplete) -> Void in
                        // DO NOTHING
                })
        })
    }
}

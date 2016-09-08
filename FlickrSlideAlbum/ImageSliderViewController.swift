//
//  ImageSliderViewController.swift
//  FlickrSlideAlbum
//
//  Created by Tae-moonCho on 2016. 8. 21..
//  Copyright © 2016년 . All rights reserved.
//

import UIKit
import SwiftLoader

class ImageSliderViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var urlLabel: UILabel!
    var timer: NSTimer = NSTimer()
    var showInfo = true
    lazy var currentFeed: Feed? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTapGestureToImageView()
        self.startTimer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addTapGestureToImageView() {
        let gesture = UITapGestureRecognizer(target: self, action: Selector("showOrHideInfoLabels:"))
        self.view.addGestureRecognizer(gesture)
    }
    
    func startTimer() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let duration = appDelegate.duration
        self.timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(duration), target: self, selector: Selector("getNewFeed"), userInfo: nil, repeats: true)
        
    }
    
    func getNewFeed() {
        FeedManager.sharedInstance.getNextFeedWithBlock { (isNew, feed) -> Void in
            dispatch_async(dispatch_get_main_queue(),{
                if isNew {
                    if let aFeed = feed {
                        SwiftLoader.hide()
                        self.currentFeed = feed
                        self.changeInfomations(aFeed)
                    }
                } else {
                    SwiftLoader.show(title: "Downloading...", animated: true)
                }
            })
        }
    }
    
    private func changeInfomations(feed: Feed) {
        self.imageView.fadeOutAndIn(beforeCompleteBlock: { () -> Void in
            if let image = feed.image {
                self.imageView.image = image
            } else {
                self.imageView.image = nil
            }
        })
        if showInfo {
            self.titleLabel.fadeOutAndIn(beforeCompleteBlock: { () -> Void in
                self.titleLabel.text = feed.title
            })
            self.authorLabel.fadeOutAndIn(beforeCompleteBlock: { () -> Void in
                self.authorLabel.text = feed.author
            })
            self.urlLabel.fadeOutAndIn(beforeCompleteBlock: { () -> Void in
                self.urlLabel.text = feed.imageUrl
            })
        }
    }
    
    func showOrHideInfoLabels(sender: UITapGestureRecognizer) {
        self.showInfo = !(self.showInfo)
        if self.showInfo {
            if let feed = currentFeed {
                self.titleLabel.text = feed.title
                self.authorLabel.text = feed.author
                self.urlLabel.text = feed.imageUrl
            }
            self.titleLabel.fadeIn()
            self.authorLabel.fadeIn()
            self.urlLabel.fadeIn()
        } else {
            self.titleLabel.fadeOut()
            self.authorLabel.fadeOut()
            self.urlLabel.fadeOut()
        }
    }
}

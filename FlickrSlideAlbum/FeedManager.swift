//
//  FeedManager.swift
//  FlickrSlideAlbum
//
//  Created by Tae-moonCho on 2016. 8. 20..
//  Copyright © 2016년 HyperConnect. All rights reserved.
//

import Foundation
import Alamofire

class FeedManager: NSObject {
    private let agent = NetworkAgent.sharedInstance
    private var semaphore = dispatch_semaphore_create(1)
    private(set) var bufferFeedUnit = 0
    private(set) var feeds : Array<Feed> = Array<Feed>()
    private(set) var currentRequest : Request? = nil
    
    class var sharedInstance: FeedManager {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: FeedManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = FeedManager()
        }
        return Static.instance!
    }
    
    init(bufferFeedUnit: Int = 3) {
        super.init()
        self.bufferFeedUnit = bufferFeedUnit
        self.fetchNewFeedsIfNeed()
    }
    
    
    func hasNeedNewFeeds() -> Bool {
        return (self.feeds.count <= bufferFeedUnit)
    }
    
    func fetchNewFeedsIfNeed() {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
            dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER)
            if self.hasNeedNewFeeds() {
                self.agent.getFeedAsModelWithCompletion({ (request, response, resultArray) -> Void in
                    self.feeds.appendContentsOf(resultArray)
                    dispatch_semaphore_signal(self.semaphore)
                })
            }
        }
    }
    
    func getNextFeedWithBlock(block: (Bool, Feed?) -> Void) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
            dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER)
            if self.feeds.count >= 2 {
                block(true, self.feeds.first)
                self.feeds.removeFirst()
            } else {
                block(false, nil)
            }
            dispatch_semaphore_signal(self.semaphore)
            self.fetchNewFeedsIfNeed()
        }
    }

    private func downloadImage(feed: Feed, index: Int, completeBlock: (Bool, nextIndex: Int) -> Void) {
        if (feed.imageLoadState == FeedImageLoadState.Prepared) {
            feed.downloadImage { (complete) -> Void in
                completeBlock(complete, nextIndex: index + 1)
            }
        } else {
            completeBlock(true, nextIndex: index + 1)
        }
    }
    
    private func downloadFeedImageIfNeed() {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
            dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER)
            func completeBlock(complete: Bool, nextIndex: Int) -> Void {
                if (self.feeds.count > nextIndex) {
                    self.downloadImage(self.feeds[nextIndex], index: nextIndex, completeBlock: completeBlock)
                }
            }
            self.downloadImage(self.feeds[0], index: 0, completeBlock: completeBlock)
            dispatch_semaphore_signal(self.semaphore)
        }
    }
    

}

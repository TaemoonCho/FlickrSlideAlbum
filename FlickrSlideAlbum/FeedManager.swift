//
//  FeedManager.swift
//  FlickrSlideAlbum
//
//  Created by Tae-moonCho on 2016. 8. 20..
//  Copyright © 2016년 . All rights reserved.
//

import Foundation
import Alamofire

class FeedManager: NSObject {
    private let agent = NetworkAgent.sharedInstance
    private var semaphore = dispatch_semaphore_create(0)
    private var queue = dispatch_queue_create("FeedManagerDownloadQueue", DISPATCH_QUEUE_SERIAL)
    private(set) var bufferFeedUnit = 0
    private(set) var feeds : Array<Feed> = Array<Feed>()
    private(set) var currentRequest : Request? = nil
    private(set) var isRunning = false
    private(set) var prepared = false
    private var feedFetching = false
    private var preparedClosure: ((Bool) -> Void)?
    
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
    
    init(bufferFeedUnit: Int = 20) {
        super.init()
        self.bufferFeedUnit = bufferFeedUnit
    }
    
    func runWithPreparedBlock(block: (Bool) -> Void) {
        self.preparedClosure = block
        self.isRunning = true
        dispatch_semaphore_signal(self.semaphore)
        self.fetchNewFeedsIfNeed()
    }
    
    private func hasNeedNewFeeds() -> Bool {
        return ((self.feeds.count <= bufferFeedUnit) && !self.feedFetching)
    }
    
    func fetchNewFeedsIfNeed() {
        dispatch_async(self.queue) {
            dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER)
            if self.hasNeedNewFeeds() {
                self.feedFetching = true
                self.agent.getFeedAsModelWithCompletion({ (request, response, resultArray) -> Void in
                    self.downloadFeedImageInArray(resultArray)
                })
            }
            dispatch_semaphore_signal(self.semaphore)
        }
    }
    
    func getNextFeedWithBlock(block: (Bool, Feed?) -> Void) {
        dispatch_async(self.queue) {
            dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER)
            if self.feeds.count >= 1 {
                block(self.feeds.first?.imageLoadState == FeedImageLoadState.Done, self.feeds.first)
                self.feeds.removeFirst()
            } else {
                block(false, nil)
            }
            dispatch_semaphore_signal(self.semaphore)
            self.fetchNewFeedsIfNeed()
        }
    }

    private func downloadImage(feeds: Array<Feed>, index: Int, completeBlock: (Array<Feed>, nextIndex: Int) -> Void) {
        let feed = feeds[index]
        if (feed.imageLoadState == FeedImageLoadState.Prepared) {
            feed.downloadImage { (complete) -> Void in
                completeBlock(feeds, nextIndex: index + 1)
            }
        } else {
            completeBlock(feeds, nextIndex: index + 1)
        }
    }
    
    private func downloadFeedImageInArray(feeds: Array<Feed>) {
        dispatch_async(self.queue) {
            func completeBlock(feeds: Array<Feed>, nextIndex: Int) -> Void {
                if feeds.count > nextIndex {
                    self.downloadImage(feeds, index: nextIndex, completeBlock: completeBlock)
                } else if feeds.count == nextIndex {
                    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER)
                    if self.feeds.count == 0 {
                        self.feeds.appendContentsOf(feeds)
                    } else {
                        self.feeds.insertContentsOf(feeds, at: self.feeds.endIndex - 1)
                    }
                    self.feedFetching = false
                    dispatch_semaphore_signal(self.semaphore)
                    if !self.prepared {
                        self.prepared = true
                        if let closure = self.preparedClosure {
                            closure(self.prepared)
                        }
                    }
                }
            }
            self.downloadImage(feeds, index: 0, completeBlock: completeBlock)
        }
    }
    

}

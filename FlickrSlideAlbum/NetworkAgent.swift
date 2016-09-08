//
//  NetworkAgent.swift
//  FlickrSlideAlbum
//
//  Created by Tae-moonCho on 2016. 8. 20..
//  Copyright © 2016년 . All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class NetworkAgent {
    class var sharedInstance: NetworkAgent {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: NetworkAgent? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = NetworkAgent()
        }
        return Static.instance!
    }
    
    // public typealias CompletionHandler = (NSURLRequest?, NSHTTPURLResponse?, Result<Image>) -> Void
    // CompletionHandler 안쓰는 이유는 readability 유지를 위함.
    func getImages(URLString : String, completion block: (NSURLRequest?, NSHTTPURLResponse?, Result<Image>) -> Void) -> Request {
        return Alamofire.request(.GET, URLString).responseImage(completionHandler: block)
    }
    
    func getFeedAsModelWithCompletion(block: (NSURLRequest?, NSHTTPURLResponse?, Array<Feed>) -> Void) -> Request {
        return Alamofire.request(Router.Feed()).responseString(completionHandler: { (request, response, result) -> Void in
            if let feedArray = Feed.fromRawResponse(result.value!) {
                block(request, response, feedArray)
            }
        })
    }
    
    // self decripted
    func getFeedWithCompletion(block: (NSURLRequest?, NSHTTPURLResponse?, Result<String>) -> Void) -> Request {
        return Alamofire.request(Router.Feed()).responseString(completionHandler: block)
    }
}

//
//  Feed.swift
//  FlickrSlideAlbum
//
//  Created by Tae-moonCho on 2016. 8. 20..
//  Copyright © 2016년 HyperConnect. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftDate

internal enum FeedImageLoadState: Int {
    case Impossibility = 0, Prepared, Loading, Failed, Done, Deleted
}


class Feed: NSObject {
    lazy var title: String = ""
    lazy var link: String = ""
    lazy var feedDescription: String = ""
    lazy var author: String = ""
    lazy var author_id: String = ""
    lazy var tags: String = ""
    lazy var imageUrl : String = ""
    var taken_at: NSDate? = nil
    var published_at: NSDate? = nil
    private(set) lazy var image : UIImage? = nil
    private(set) var imageLoadState = FeedImageLoadState.Impossibility
    
    init(json: JSON) {
        super.init()
        self.title = json["title"].stringValue
        self.link = json["link"].stringValue
        self.feedDescription = json["description"].stringValue
        self.author = json["author"].stringValue
        self.author_id = json["author_id"].stringValue
        self.tags = json["tags"].stringValue
        self.taken_at = json["date_taken"].stringValue.toDate(DateFormat.ISO8601)!
        self.published_at = json["published"].stringValue.toDate(DateFormat.ISO8601)!
        if let media = json["media"]["m"].string {
            self.imageUrl = media
            self.imageLoadState = .Prepared
        }
    }
    
    func downloadImage(completion : (Bool) -> Void) {
        self.imageLoadState = .Loading
        NetworkAgent.sharedInstance.getImages(self.imageUrl) { (request, response, resultImage) -> Void in
            self.image = resultImage.value
            self.imageLoadState = .Done
            completion(true)
        }
    }
    
    func removeImage() {
        if image != nil {
            image = nil
            self.imageLoadState = .Deleted
        }
    }
    
    
    class func fromArray(jsons: Array<JSON>) -> Array<Feed>? {
        if jsons.count < 1 { return nil }
        var feedArray: Array<Feed> = []
        for (_, json) in jsons.enumerate() {
            feedArray.append(Feed(json: json))
        }
        return feedArray
    }
    
    class func fromRawResponse(rawResponse: String) -> Array<Feed>? {
        let targetString = "jsonFlickrFeed("
        var json : JSON? = nil
        if rawResponse.rangeOfString(targetString) != nil {
            let processedJsonString = String(rawResponse.stringByReplacingOccurrencesOfString(targetString, withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil).stringByReplacingOccurrencesOfString("\\'", withString: "'").characters.dropLast())
            json = processedJsonString.json
        } else {
            json = rawResponse.json
        }
        if let itemArray = json?["items"].array {
            return self.fromArray(itemArray)
        } else {
            return nil
        }
    }
}

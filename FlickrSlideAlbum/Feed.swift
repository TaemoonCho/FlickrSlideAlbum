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
    
//    let timezone = DateRegion(timeZoneName: TimeZoneName(rawValue: "Asia/Seoul"))
    
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
}
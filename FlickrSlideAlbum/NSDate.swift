//
//  NSDate.swift
//  FlickrSlideAlbum
//
//  Created by Tae-moonCho on 2016. 8. 20..
//  Copyright © 2016년 HyperConnect. All rights reserved.
//

import Swift
import Foundation
import SwiftDate

extension NSDate {
    var toStringInSeoul: String? {
        let timezone = DateRegion(timeZoneName: TimeZoneName(rawValue: "Asia/Seoul"))
        return self.toString(DateFormat.Custom("YYYY-MM-dd HH:mm:ss"), inRegion: timezone)
    }
}

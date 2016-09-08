//
//  String+Json.swift
//  FlickrSlideAlbum
//
//  Created by Tae-moonCho on 2016. 8. 20..
//  Copyright © 2016년 . All rights reserved.
//

import Swift
import Foundation
import SwiftyJSON

extension String {
    var json: JSON? {
        if let data = self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            return JSON(data: data)
        }
        return nil
    }
}

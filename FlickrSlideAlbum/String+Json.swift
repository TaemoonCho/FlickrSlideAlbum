//
//  String+Json.swift
//  FlickrSlideAlbum
//
//  Created by Tae-moonCho on 2016. 8. 20..
//  Copyright © 2016년 HyperConnect. All rights reserved.
//

import Swift
import Foundation
import SwiftyJSON

//extension String {
//    var parseJSONString: AnyObject? {
//        do {
//            let data = self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
//            if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
//                return jsonResult
//            }
//        } catch let error as NSError {
//            print(error.localizedDescription)
//            return nil
//        }
//        return nil
//    }
//}

extension String {
    var json: JSON? {
        if let data = self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            return JSON(data: data)
        }
        return nil
    }
}

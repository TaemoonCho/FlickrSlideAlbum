//
//  Router.swift
//  FlickrSlideAlbum
//
//  Created by Tae-moonCho on 2016. 8. 20..
//  Copyright © 2016년 HyperConnect. All rights reserved.
//

import Foundation
import Alamofire

public enum Format: String {

    case JSON = "json"
    // php, php_serial, csv, json, sql, yaml, cdf
    // rss2, atom, rss, rdf, rss_200_enc
    // json 외 생략.
    
    public var stringValue: String {
        switch self {
        case .JSON :
            return "json"
        }
    }
}

public enum Router : URLRequestConvertible {
    static let baseURL = "https://api.flickr.com/services"
    
    case FeedWith(format: Format)
    case Feed()
    // groups_discuss 그룹
    // 기타 API 생략.
    
    var method: Alamofire.Method {
        switch self {
        case .FeedWith:
            return .GET
        case .Feed:
            return .GET
        }
    }
    
    public var URLRequest: NSMutableURLRequest {
        let result: (path: String, parameters: [String: AnyObject]) = {
            switch self {
            case .FeedWith(let format) :
                return ("/feeds/photos_public.gne", ["format": format.stringValue])
            case .Feed() :
                return ("/feeds/photos_public.gne", ["format": Format.JSON.stringValue])
            }
        }()
        
        let URL = NSURL(string: Router.baseURL)!
        let URLRequest = NSURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
        let encoding = Alamofire.ParameterEncoding.URL
        
        return encoding.encode(URLRequest, parameters: result.parameters).0
    }
}
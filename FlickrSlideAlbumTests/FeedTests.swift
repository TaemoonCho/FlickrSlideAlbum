import Quick
import Nimble
import SwiftDate

class FeedTests: QuickSpec {
    override func spec() {
        describe("Feed Model") {
            context("From JSON") {
                let rawJsonString = "jsonFlickrFeed({\n\t\t\"title\": \"Uploads from everyone\",\n\t\t\"link\": \"https://www.flickr.com/photos/\",\n\t\t\"description\": \"\",\n\t\t\"modified\": \"2016-08-19T15:31:57Z\",\n\t\t\"generator\": \"https://www.flickr.com/\",\n\t\t\"items\": [\n\t   {\n\t\t\t\"title\": \"Sign on Finssnes building\",\n\t\t\t\"link\": \"https://www.flickr.com/photos/ayjay3/28467650054/\",\n\t\t\t\"media\": {\"m\":\"https://farm9.staticflickr.com/8860/28467650054_cc394b1d9e_m.jpg\"},\n\t\t\t\"date_taken\": \"2014-02-21T11:59:01-08:00\",\n\t\t\t\"description\": \" <p><a href=\\\"https://www.flickr.com/people/ayjay3/\\\">ayjay3<\\/a> posted a photo:<\\/p> <p><a href=\\\"https://www.flickr.com/photos/ayjay3/28467650054/\\\" title=\\\"Sign on Finssnes building\\\"><img src=\\\"https://farm9.staticflickr.com/8860/28467650054_cc394b1d9e_m.jpg\\\" width=\\\"240\\\" height=\\\"180\\\" alt=\\\"Sign on Finssnes building\\\" /><\\/a><\\/p> <p>Sign on Finssnes building<\\/p>\",\n\t\t\t\"published\": \"2016-08-19T15:31:57Z\",\n\t\t\t\"author\": \"nobody@flickr.com (ayjay3)\",\n\t\t\t\"author_id\": \"33738698@N05\",\n\t\t\t\"tags\": \"sign\"\n\t   },\n\t   {\n\t\t\t\"title\": \"Nike Air Max ST switched up my #sneakerhead ways from basketball shoes to more runners and trainers in line with my #workoutobsession #nike #sneakerfreaker #kicksoftheday\",\n\t\t\t\"link\": \"https://www.flickr.com/photos/lynneluvah/28467650224/\",\n\t\t\t\"media\": {\"m\":\"https://farm8.staticflickr.com/7577/28467650224_0ef0d0ac74_m.jpg\"},\n\t\t\t\"date_taken\": \"2016-08-19T11:31:58-08:00\",\n\t\t\t\"description\": \" <p><a href=\\\"https://www.flickr.com/people/lynneluvah/\\\">lynneluvah<\\/a> posted a photo:<\\/p> <p><a href=\\\"https://www.flickr.com/photos/lynneluvah/28467650224/\\\" title=\\\"Nike Air Max ST switched up my #sneakerhead ways from basketball shoes to more runners and trainers in line with my #workoutobsession #nike #sneakerfreaker #kicksoftheday\\\"><img src=\\\"https://farm8.staticflickr.com/7577/28467650224_0ef0d0ac74_m.jpg\\\" width=\\\"240\\\" height=\\\"240\\\" alt=\\\"Nike Air Max ST switched up my #sneakerhead ways from basketball shoes to more runners and trainers in line with my #workoutobsession #nike #sneakerfreaker #kicksoftheday\\\" /><\\/a><\\/p> \",\n\t\t\t\"published\": \"2016-08-19T15:31:58Z\",\n\t\t\t\"author\": \"nobody@flickr.com (lynneluvah)\",\n\t\t\t\"author_id\": \"30337486@N00\",\n\t\t\t\"tags\": \"instagramapp square squareformat iphoneography uploaded:by=instagram amaro\"\n\t   }\n\t\t]\n})"
                
                var array : Array<Feed>? = nil
                
                context("From raw response") {
                    it("Should get feeds in array") {
                        expect(array).to(beNil())
                        array = Feed.fromRawResponse(rawJsonString)
                        expect(array?.count).to(equal(2))
                        expect(array?.first?.imageUrl).to(match("https://farm9.staticflickr.com/8860/28467650054_cc394b1d9e_m.jpg"))
                        expect(array?.last?.imageUrl).to(match("https://farm8.staticflickr.com/7577/28467650224_0ef0d0ac74_m.jpg"))
                    }
                }
                
                context("From JSON") {
                    let processedJsonString = String(rawJsonString.stringByReplacingOccurrencesOfString("jsonFlickrFeed(", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil).characters.dropLast())
                    let json = processedJsonString.json
                    it("Should get feeds in array") {
                        let array = Feed.fromArray((json?["items"].arrayValue)!)
                        expect(array?.count).to(equal(2))
                        expect(array?.first?.imageUrl).to(match("https://farm9.staticflickr.com/8860/28467650054_cc394b1d9e_m.jpg"))
                        expect(array?.last?.imageUrl).to(match("https://farm8.staticflickr.com/7577/28467650224_0ef0d0ac74_m.jpg"))
                    }
                    it("Should get Feed instance") {
                        let aFeed = Feed(json: (json?["items"][0])!) as Feed
                        expect(aFeed.title).to(match("Sign on Finssnes building"))
                        expect(aFeed.link).to(match("https://www.flickr.com/photos/ayjay3/28467650054/"))
                        expect(aFeed.feedDescription).to(match(" <p><a href=\"https://www.flickr.com/people/ayjay3/\">ayjay3</a> posted a photo:</p> <p><a href=\"https://www.flickr.com/photos/ayjay3/28467650054/\" title=\"Sign on Finssnes building\"><img src=\"https://farm9.staticflickr.com/8860/28467650054_cc394b1d9e_m.jpg\" width=\"240\" height=\"180\" alt=\"Sign on Finssnes building\" /></a></p> <p>Sign on Finssnes building</p>"))
                        expect(aFeed.author).to(match("nobody@flickr.com (ayjay3)"))
                        expect(aFeed.author_id).to(match("33738698@N05"))
                        expect(aFeed.tags).to(match("sign"))
                        expect(aFeed.imageUrl).to(match("https://farm9.staticflickr.com/8860/28467650054_cc394b1d9e_m.jpg"))
                        expect(aFeed.taken_at?.toStringInSeoul).to(match("2014-02-22 04:59:01"))
                        expect(aFeed.published_at?.toStringInSeoul).to(match("2016-08-20 00:31:57"))
                    }
                }
                
                context("Image download") {
                    it("Should can download image") {
                        let firstitem = array?.first
                        let secondItme = array?.last
                        var firstItemImageData : NSData? = nil
                        var secondItemImageData : NSData? = nil
                        expect(firstitem?.imageLoadState == .Prepared).to(beTrue())
                        expect(secondItme?.imageLoadState == .Prepared).to(beTrue())
                        firstitem?.downloadImage({ (isSuccess) -> Void in
                            firstItemImageData = NSData(data: UIImageJPEGRepresentation((firstitem?.image)!, 1)!)
                        })
                        expect(firstitem?.imageLoadState == .Loading).to(beTrue())
                        secondItme?.downloadImage({ (isSuccess) -> Void in
                            secondItemImageData = NSData(data: UIImageJPEGRepresentation((secondItme?.image)!, 1)!)
                        })
                        expect(secondItme?.imageLoadState == .Loading).to(beTrue())
                        expect(firstitem?.imageLoadState == .Done).toEventually(beTrue())
                        expect(secondItme?.imageLoadState == .Done).toEventually(beTrue())
                        expect(firstItemImageData?.length).toEventually(beGreaterThan(10000))
                        expect(secondItemImageData?.length).toEventually(beGreaterThan(10000))
                    }
                }
            }
        }
    }
}

import Quick
import Nimble

class NetworkAgentTests: QuickSpec {
    override func spec() {
        let agent = NetworkAgent.sharedInstance
        context("Get shared instance as singleton") {
            let newAgent = NetworkAgent.sharedInstance
            it("Should be same memory address") {
                expect(newAgent).notTo(beNil())
                expect(newAgent).to(beIdenticalTo(agent))
            }
            
        }
        context("Single image download") {
            let urlString = "https://farm9.staticflickr.com/8241/28463069214_bb3abc68eb_m.jpg"
            var image : UIImage? = nil
            var imageData : NSData? = nil
            it("Should get target that on the url") {
                expect(image).to(beNil())
                agent.getImages(urlString, completion: { (request, resopnse, resultImage) -> Void in
                    image = resultImage.value
                    imageData = NSData(data: UIImageJPEGRepresentation(image!, 1)!)
                })
                expect(image).toNotEventually(beNil())
                expect(image?.size.width).toEventually(equal(120))
                expect(image?.size.height).toEventually(equal(120))
                expect(imageData).toNotEventually(beNil())
                expect(imageData?.length).toEventually(equal(52779));
            }
        }
        
        context("Feeds") {
            var responseString : String = ""
            it("Should get response JSON") {
                agent.getFeedWithCompletion({ (request, response, resultString) -> Void in
                    responseString = resultString.value!
                })
                expect(responseString).toNotEventually(match(""))
                expect(responseString.characters.count).toEventually(beGreaterThan(1000))
            }
        }
        
        context("Feeds response to Feed model") {
            var feedArray : Array<Feed>? = nil
            it("Should get Feeds in Array") {
                expect(feedArray).to(beNil())
                agent.getFeedAsModelWithCompletion({ (request, response, resultArray) -> Void in
                    feedArray = resultArray
                })
                expect(feedArray).toNotEventually(beNil())
                expect(feedArray?.count).toEventually(beGreaterThan(5))
            }
        }
    }
}

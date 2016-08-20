import Quick
import Nimble
//import Alamofire

class RouterTests: QuickSpec {
    override func spec() {
        describe("Router") {
            context("FeedWith") {
                let request = Router.FeedWith(format: Format.JSON)
                it("Should make request") {
                    expect(request).notTo(beNil())
                    expect(request.URLRequest).to(beAKindOf(NSMutableURLRequest))
                    expect(request.URLRequest.URLString).to(match("https://api.flickr.com/services/feeds/photos_public.gne?format=json"))
                    expect(request.URLRequest.HTTPMethod).to(match("GET"))
                }
            }
            context("Feed") {
                // DO NO ANYTHING CUZ SAME TO FOLLOW UP
            }
        }
    }
}

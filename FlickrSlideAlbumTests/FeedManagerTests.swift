import Quick
import Nimble

class FeedManagerTests: QuickSpec {
    override func spec() {
        describe("Feed manager download test") {
            let manager = FeedManager.sharedInstance
            it("Shoul get shared instance") {
                expect(manager).notTo(beNil());
                expect(manager.feeds.count).toEventuallyNot(beGreaterThan(3), timeout: 1000000, pollInterval: 1, description: "");
            }
        }
    }
}

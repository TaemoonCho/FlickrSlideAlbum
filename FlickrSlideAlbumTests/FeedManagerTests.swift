import Quick
import Nimble

class FeedManagerTests: QuickSpec {
    override func spec() {
        describe("Feed manager download test") {
            let manager = FeedManager.sharedInstance
            context("Create") {
                it("Should get shared instance as singleton") {
                    let anotherManager = FeedManager.sharedInstance
                    expect(manager).notTo(beNil())
                    expect(anotherManager).to(beIdenticalTo(manager))
                }
            }
            context("Working") {
                var isPrepared = false
                var firstFeed: Feed? = nil
                var secondFeed: Feed? = nil
                it("Should work the worker thread") {
                    expect(manager.isRunning).to(beFalse())
                    expect(firstFeed).to(beNil())
                    expect(secondFeed).to(beNil())
                    expect(manager.feeds.count).to(equal(0))
                    manager.runWithPreparedBlock({ (prepared) -> Void in
                        isPrepared = prepared
                        manager.getNextFeedWithBlock({ (isNew, aFeed) -> Void in
                            firstFeed = aFeed
                        })
                        manager.getNextFeedWithBlock({ (isNew, aFeed) -> Void in
                            secondFeed = aFeed
                        })
                    })

                    expect(isPrepared).toEventually(beTrue(), timeout: 1000, pollInterval: 1, description: "")
                    expect(firstFeed).toEventuallyNot(beNil(), timeout: 1500, pollInterval: 1, description: "")
                    expect(secondFeed).toEventuallyNot(beNil(), timeout: 1500, pollInterval: 1, description: "")
                    expect(firstFeed).notTo(beIdenticalTo(secondFeed))
                    expect(manager.feeds.count).toEventually(beGreaterThan(10), timeout: 1000, pollInterval: 1, description: "")
                }
            }
        }
    }
}

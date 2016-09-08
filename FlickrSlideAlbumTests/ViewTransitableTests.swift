import Quick
import Nimble
import UIKit


extension UIView: ViewTransitable { }

class ViewTransitableTests: QuickSpec {
    override func spec() {
        describe("ViewTransitable") {
            let view = UIView(frame: CGRectMake(50, 50, 50, 50))
            it("Should view transitable") {
                expect(view).notTo(beNil());
                expect(view.alpha).to(equal(1.0))
            }
            context("fade in out ") {
                beforeEach({ 
                    view.alpha = 1.0
                });
                view.fadeOut()
                expect(view.alpha).toEventually(equal(0.0), timeout: 1, pollInterval: 0.1, description: "")
                view.fadeIn()
                expect(view.alpha).toEventually(equal(1.0), timeout: 1, pollInterval: 0.1, description: "")
                view.fadeOutAndIn(beforeCompleteBlock: { 
                   // DO NOTHING
                });
                expect(view.alpha).toEventually(equal(0.0), timeout: 1, pollInterval: 0.1, description: "")
                expect(view.alpha).toEventually(equal(1.0), timeout: 1, pollInterval: 0.1, description: "")
                
            }
        }
    }
}

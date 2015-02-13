import Quick
import Nimble

class ViewControllerSpec: QuickSpec {
    override func spec() {
        describe("the application's view controller", {
            context("when created from storyboard", {
                it("should be the inital view controller of the 'Main' storyboard - found from its restoration id", {
                    let storyboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: ViewController.self))
                    let viewController = storyboard.instantiateInitialViewController() as UIViewController
                    expect(viewController.restorationIdentifier).to(equal("ViewController"))
                })
            })
        })
    }
}

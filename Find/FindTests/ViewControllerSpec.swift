import Quick
import Nimble

class ViewControllerSpec: QuickSpec {
    override func spec() {
        describe("the application's view controller", {

            
            context("Creation", {
                it("should be created from the Main storyboard", {
                    let storyboard = UIStoryboard(name: "Main", bundle: NSBundle(forClass: ViewController.self))
                    let viewController = storyboard.instantiateInitialViewController() as UIViewController
                    expect(viewController.restorationIdentifier).to(equal("ViewController"))
                })
            })
            
            context("Outlets", {
                it("should ", {
                    
                })
            })
        })
    }
}

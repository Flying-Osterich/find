import Quick
import Nimble

class ViewControllerSpec: QuickSpec {
    override func spec() {
        describe("the application's view controller") {
            context("when created from storyboard") {
                it("should be the inital view controller of the 'Main' storyboard - found from its restoration id", {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateInitialViewController() as! UIViewController
                    expect(viewController) != nil
                    expect(viewController.restorationIdentifier) == "ViewController"
                })
                
                describe("its outlets") {
                    xit("should have a text view amoung them", {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let appVC = storyboard.instantiateInitialViewController() as? ViewController
                        let textView = appVC?.textView
                        expect(textView) != nil
                    })
                }
            }
        }
    }
}

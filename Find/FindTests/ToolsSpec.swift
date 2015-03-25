import Quick
import Nimble

class ToolsSpec: QuickSpec {
    override func spec() {
        describe("Equatables") {
            it("should match NSRange") {
                let range1 = NSMakeRange(0, 0)
                let range2 = NSMakeRange(0, 0)
                let range3 = NSMakeRange(2, 2)
                
                expect(range1) == range2
                expect(range1) != range3
            }
        }
    }
}

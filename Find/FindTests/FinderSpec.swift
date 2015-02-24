import Quick
import Nimble

class FinderSpec: QuickSpec {
    override func spec() {
        describe("a Finder") {
            it("should locate a word in a string of words") {
                let stringOfWords = "this is a string of words"
                let finder = Finder()
                let range = finder.find("word", inString: stringOfWords)
                let length = range.length
                expect(range.length).to(equal(4))
                expect(range.location).to(equal(20))
            }
        }
    }
}

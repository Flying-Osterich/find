import Quick
import Nimble

class FinderSpec: QuickSpec {
    override func spec() {
        describe("a Finder") {
            it("should locate a word in a collection of words") {
                let collectionOfWords = ["this", "is", "a", "collection", "of", "words"]
                let finder = Finder()
                let location = finder.find("words", inTheArray: collectionOfWords)
                expect(location).to(equal(5))
            }
        }
    }
}

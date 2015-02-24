import Quick
import Nimble

class FinderSpec: QuickSpec {
    override func spec() {
        describe("a Finder") {
            it("should locate all the occurances of a string in a string") {
                let stringOfWords = "these words make a string of words"
                let finder = Finder()
                let ranges = finder.find("word", inString: stringOfWords)
                
                let firstOccurance = ranges[0]
                expect(firstOccurance.length).to(equal(4))
                expect(firstOccurance.location).to(equal(6))
                
                let secondOccurance = ranges[1]
                expect(secondOccurance.length).to(equal(4))
                expect(secondOccurance.location).to(equal(29))
            }
        }
    }
}

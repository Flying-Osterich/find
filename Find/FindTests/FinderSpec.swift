import Quick
import Nimble

class FinderSpec: QuickSpec {
    override func spec() {
        describe("a Finder") {
            it("should locate the first occurance of a string in a string") {
                let stringOfWords = "these words make a string of words"
                let finder = Finder()
                if let range = finder.findFirst("word", inString: stringOfWords) {
                    expect(range.length).to(equal(4))
                    expect(range.location).to(equal(6))
                } else {
                    assert(false, "range not found")
                }
            }
            
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
            
            describe("#find:inString:") {
                it("should return an empty array if a match was not found") {
                    let string = "this is a string with characters"
                    let finder = Finder()
                    let ranges = finder.find("word", inString: string)
                    expect(ranges).to(equal([]))
                }
            }
        }
    }
}

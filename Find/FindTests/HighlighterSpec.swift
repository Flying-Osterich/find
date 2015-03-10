import Quick
import Nimble

class HighlighterSpec: QuickSpec {
    override func spec() {
        describe("a Highlighter") {
            it("should change the backgroundColor to highlight a string within a string", {
                
                let string = "a String"
                let enclosingString = "there is a String in this string"
                let rangeOfString = NSMakeRange(9, 8)
                
                let highlighter = Highlighter()
                let attributedEnclosedString = highlighter.highlight(string, inString:enclosingString)

                var hasAttributes = false
                attributedEnclosedString.enumerateAttribute(NSBackgroundColorAttributeName, inRange: NSMakeRange(0, attributedEnclosedString.length), options: .LongestEffectiveRangeNotRequired) { (var value, var range, stop) in
                    hasAttributes = true
                    if range == rangeOfString  {
                        expect(value).notTo(beNil())
                        expect(value as? NSObject).to(beAKindOf(UIColor))
                    }
                }
                expect(hasAttributes).to(beTrue())
            })
        }
    }
}

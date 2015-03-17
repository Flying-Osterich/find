import Quick
import Nimble

class ParserSpec: QuickSpec {
    override func spec() {
        describe("a Parser") {
            context("for HTML") {
                it("should find all the plain text in a html document", {
                    let fileOpener = FileOpener()
                    let htmlDoc = fileOpener.open("sun.html")
                    println("\(htmlDoc)")
                })
            }
        }
    }
}

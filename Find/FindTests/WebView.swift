import Quick
import Nimble

class WebViewSpec: QuickSpec {
    override func spec() {
        describe("WebView") {
            it("will inject javascript into its html") {
                let fileName = "sun.html"
                let fileOpener = FileOpener()
                if let htmlDoc = fileOpener.open(fileName) {
                    let webView = WebView()
                    webView.loadHTMLString(htmlDoc as String, baseURL:NSURL(string: "http://en.wikipedia.org/wiki/Sun"))
                    webView.injectJavaScriptFromFile("javascript")
                    let scriptElements = webView.stringByEvaluatingJavaScriptFromString("return document.scripts")
                    println("\(scriptElements)")
                } else {
                    assert(false, "unable to open \(fileName)")
                }
            }
        }
    }
}

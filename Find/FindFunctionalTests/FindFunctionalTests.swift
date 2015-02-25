//
//  FindFunctionalTests.swift
//  FindFunctionalTests
//
//  Created by Justin.Dombecki on 2/18/15.
//  Copyright (c) 2015 Justin.Dombecki. All rights reserved.
//

class FunctionalTests: KIFTestCase {
    func clearTextFromTextView() {
        tester.clearTextFromViewWithAccessibilityLabel(TextView.searchableContent.rawValue)
    }
    
    func clearTextFromTextField() {
        tester.clearTextFromViewWithAccessibilityLabel(TextField.searchInput.rawValue)
    }
}


class AddTextTests: FunctionalTests {
    
    func testTextToTextView() {
        clearTextFromTextView()
        addTextToTextView()
    }
    
}

class HighlightTextTests: FunctionalTests {
    
    func testHighlightWordInSentence() {
        clearTextFromTextView()
        addTextToTextView()
        
        clearTextFromTextField()
        addSearchToTextField()
        
        pressFindButton()
        verifyTextIsHighlightedYellow()
    }
    
}

// MARK: Test Details

private extension AddTextTests {
    
    func addTextToTextView() {
        tester.enterText(TextInput.content.rawValue, intoViewWithAccessibilityLabel: TextView.searchableContent.rawValue)
        tester.waitForViewWithAccessibilityLabel(TextView.searchableContent.rawValue, value: TextInput.content.rawValue, traits: UIAccessibilityTraitNone)
    }
}

private extension HighlightTextTests {
    func addTextToTextView() {
        tester.enterText(TextViewInput.content.rawValue, intoViewWithAccessibilityLabel: TextView.searchableContent.rawValue)
    }
    
    func addSearchToTextField() {
        tester.enterText(TextFieldInput.content.rawValue, intoViewWithAccessibilityLabel: TextField.searchInput.rawValue)
    }
    
    func pressFindButton() {
        tester.tapViewWithAccessibilityLabel(FindButton.findButton.rawValue)
    }
    
    func verifyTextIsHighlightedYellow() {
        let textView = tester.waitForViewWithAccessibilityLabel(TextView.searchableContent.rawValue, traits: UIAccessibilityTraitNone) as UITextView
        
        var hasAttributes = false
        var hasHighlight = false
        textView.attributedText.enumerateAttribute(NSBackgroundColorAttributeName, inRange: NSMakeRange(0, textView.attributedText.length), options: .LongestEffectiveRangeNotRequired) { (var value, var range, stop) in
            hasAttributes = true
            if value is UIColor  {
                hasHighlight = true
                XCTAssertEqual(value as UIColor, UIColor.yellowColor(), "Highlight should be yellow")
            }
        }
        XCTAssert(hasAttributes, "Text of the textView should have attributes")
        XCTAssert(hasHighlight, "Text of the textView should have a highlighted attribute")
    }
}

// MARK: Setup Accessibility Labels

private extension FunctionalTests {
    enum FindButton: String {
        case findButton = "Find Button"
    }
    
    enum TextView: String {
        case searchableContent = "Searchable Content"
    }
    
    enum TextField: String {
        case searchInput = "Search Input"
    }
}

private extension AddTextTests {
    enum TextInput: String {
        case content = "If this is visible, the text view is accepting text."
    }
}

private extension HighlightTextTests {
    enum TextViewInput: String {
        case content = "In this sentence, there should be a highlighted word or words that contain 'word'."
    }
    
    enum TextFieldInput: String {
        case content = "word"
    }
}
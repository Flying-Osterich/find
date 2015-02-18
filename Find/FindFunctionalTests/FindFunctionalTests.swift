//
//  FindFunctionalTests.swift
//  FindFunctionalTests
//
//  Created by Justin.Dombecki on 2/18/15.
//  Copyright (c) 2015 Justin.Dombecki. All rights reserved.
//

class AddTextTests: KIFTestCase {
    
    func testTextToTestView() {
        addTextToTextView()
    }
    
}

// MARK: Test Details

private extension AddTextTests {
    
    func addTextToTextView() {
        tester.enterText(TextInput.Content.rawValue, intoViewWithAccessibilityLabel: TextView.searchableContent.rawValue)
        tester.waitForViewWithAccessibilityLabel(TextView.searchableContent.rawValue, value: TextInput.Content.rawValue, traits: UIAccessibilityTraitNone)
    }
}

// MARK: Setup Accessibility Labels

private extension AddTextTests {
    enum TextView: String {
        case searchableContent = "Searchable Content"
    }
    
    enum TextInput: String {
        case Content = "If this is visible, the text view is accepting text."
    }
}
//
//  Highlighter.swift
//  Find
//
//  Created by Justin.Dombecki on 2/24/15.
//  Copyright (c) 2015 Justin.Dombecki. All rights reserved.
//

import Foundation
import UIKit

extension String
{
    func index(intIndex: Int) -> Index {
        var index = self.startIndex
        for _ in 0...intIndex {
            index = index.successor()
        }
        return index
    }
}

class Highlighter {
    func highlight(string:String, inString:String) -> NSAttributedString {
        let mutableAttibutedString = NSMutableAttributedString(string: inString)
        
        let ranges = Finder().find(string, inString: inString)
        for range in ranges {
            mutableAttibutedString.addAttribute(NSBackgroundColorAttributeName, value: UIColor.yellowColor(), range: range)
        }
        
        return mutableAttibutedString.copy() as! NSAttributedString
    }
    
    func highlight(string:String, inHtml:String) -> String {
        var mutString = inHtml
        if let rangeOfString = Finder().findFirst(string, inString: inHtml) {
            mutString.splice("</mark>", atIndex: inHtml.index(rangeOfString.location + rangeOfString.length))
            mutString.splice("<mark>", atIndex: inHtml.index(rangeOfString.location))
        }
        return mutString
    }
}

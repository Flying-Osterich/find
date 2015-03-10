//
//  Highlighter.swift
//  Find
//
//  Created by Justin.Dombecki on 2/24/15.
//  Copyright (c) 2015 Justin.Dombecki. All rights reserved.
//

import Foundation
import UIKit

class Highlighter {
    func highlight(string:String, inString:String) -> NSAttributedString {
        let mutableAttibutedString = NSMutableAttributedString(string: inString)
        
        let ranges = Finder().find(string, inString: inString)
        for range in ranges {
            mutableAttibutedString.addAttribute(NSBackgroundColorAttributeName, value: UIColor.yellowColor(), range: range)
        }
        
        return mutableAttibutedString.copy() as! NSAttributedString
    }
}
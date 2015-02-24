//
//  Finder.swift
//  Find
//
//  Created by Justin.Dombecki on 2/21/15.
//  Copyright (c) 2015 Justin.Dombecki. All rights reserved.
//

import Foundation

class Finder {
    func find(theWord:String, inString:String) -> NSRange {
        var range = NSMakeRange(0, 0)
        var error: NSError?
        let wantedRegex = NSRegularExpression(pattern: "\(theWord)", options: .CaseInsensitive, error: &error)
        if let regex = wantedRegex  {
            let count = countElements(inString)
            regex.enumerateMatchesInString(inString, options: .ReportProgress, range: NSMakeRange(0, count), usingBlock: { (var result, var matchingFlags, var stop) in
                if (result != nil) {
                    println("\(result)")
                    range = result.range
                }
            })
        }
        return range
    }
}
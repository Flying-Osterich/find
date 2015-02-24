//
//  Finder.swift
//  Find
//
//  Created by Justin.Dombecki on 2/21/15.
//  Copyright (c) 2015 Justin.Dombecki. All rights reserved.
//

import Foundation

class Finder {
    func find(string:String, inString:String) -> [NSRange] {
        var error: NSError?
        var ranges = [NSRange]()
        let expectedRegex = NSRegularExpression(pattern: "\(string)", options: .CaseInsensitive, error: &error)
        if let regex = expectedRegex  {
            let count = countElements(inString)
            regex.enumerateMatchesInString(inString, options: .ReportProgress, range: NSMakeRange(0, count)) { (var result, var matchingFlags, var stop) in
                if (result != nil) {
                    ranges += [result.range]
                }
            }
        }
        return ranges
    }
}

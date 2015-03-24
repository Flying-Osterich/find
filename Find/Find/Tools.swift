//
//  Tools.swift
//  Find
//
//  Created by Justin.Dombecki on 2/24/15.
//  Copyright (c) 2015 Justin.Dombecki. All rights reserved.
//

import Foundation


// MARK: Equatable

extension NSRange : Equatable { }
public func ==(lhs: NSRange, rhs: NSRange) -> Bool {
    return NSEqualRanges(lhs, rhs)
}
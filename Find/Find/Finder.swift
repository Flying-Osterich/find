//
//  Finder.swift
//  Find
//
//  Created by Justin.Dombecki on 2/21/15.
//  Copyright (c) 2015 Justin.Dombecki. All rights reserved.
//

import Foundation

class Finder {
    func find(theWord:String, inTheArray:[String]) -> Int {
        for (index, word) in enumerate(inTheArray) {
            if word == theWord {
                return index
            }
        }
        return -1
    }
}
//
//  TestTools.swift
//  Find
//
//  Created by Justin.Dombecki on 3/16/15.
//  Copyright (c) 2015 Justin.Dombecki. All rights reserved.
//

import Foundation

class FileOpener {
    
    func open(filename : String) -> NSString? {
        var string : NSString?
        
        let filenameParts = split(filename) {$0 == "."}
        let name = filenameParts[0]
        let fileExtension : String? = filenameParts.count > 1 ? filenameParts[1] : nil
        
        var loadError: NSError?
        let bundle = NSBundle(forClass: FileOpener.self)
        if let pathToFile = bundle.pathForResource(name, ofType: fileExtension) {
            if let stringFromFile = NSString(contentsOfFile: pathToFile, encoding: NSASCIIStringEncoding, error: &loadError) {
                if let error = loadError {
                    assert(false, "failed to load file at path \(pathToFile) with error \(error)")
                } else {
                    string = stringFromFile
                }
            } else {
                assert(false, "received nil from loading file at path \(pathToFile)")
            }

        } else {
            assert(false, "could not find path for resource \(name).\(fileExtension) in bundle \(bundle)")
        }
        return string
    }
}
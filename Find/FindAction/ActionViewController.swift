//
//  ActionViewController.swift
//  FindAction
//
//  Created by Justin.Dombecki on 3/11/15.
//  Copyright (c) 2015 Justin.Dombecki. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Get the item[s] we're handling from the extension context.
        
        // For example, look for an image and place it into an image view.
        // Replace this with something appropriate for the type[s] your extension supports.
        var imageFound = false
        for item: AnyObject in self.extensionContext!.inputItems {
            println("\(item)")
            let inputItem = item as! NSExtensionItem
            for provider: AnyObject in inputItem.attachments! {
                println("\(provider)")
                let itemProvider = provider as! NSItemProvider
                if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeHTML as String) {
                    itemProvider.loadItemForTypeIdentifier(kUTTypeHTML as String, options: nil, completionHandler: { (htmlText, error) in
                        println("\(htmlText)")
                    })
                } else if itemProvider.hasItemConformingToTypeIdentifier(kUTTypeURL as String) {
                    itemProvider.loadItemForTypeIdentifier(kUTTypeURL as String, options: nil, completionHandler: { (url, error) in
                        if url != nil {
                            var loadError: NSError?
                            let html = NSString(contentsOfURL: url as! NSURL, encoding: NSASCIIStringEncoding, error: &loadError)
                            if (html == nil) {
                                if let error = loadError {
                                    println("loading url failure: \(error.localizedDescription)")
                                }
                            } else {
                                println("\(html)")
                            }
                        }
                    })
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequestReturningItems(self.extensionContext!.inputItems, completionHandler: nil)
    }

}

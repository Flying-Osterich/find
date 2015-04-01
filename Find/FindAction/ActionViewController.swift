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
    
        for item: AnyObject in self.extensionContext!.inputItems {
            println("\(item)")
            let inputItem = item as! NSExtensionItem
            for provider: AnyObject in inputItem.attachments! {
                let itemProvider = provider as! NSItemProvider
                itemProvider.loadItemForTypeIdentifier(kUTTypePropertyList as String, options: nil, completionHandler:{ (thing, error) in
                    println("have the kUTTypePropertyList thing \(thing)")
                })
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done() {
        let extensionItem = NSExtensionItem()
        extensionItem.attachments = [NSItemProvider(item: [NSExtensionJavaScriptFinalizeArgumentKey:["bgColor":"red"]],
                                          typeIdentifier: kUTTypePropertyList as String)]
        self.extensionContext!.completeRequestReturningItems([extensionItem], completionHandler: nil)
    }

}
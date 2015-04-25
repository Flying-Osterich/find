//
//  ActionViewController.swift
//  FindAction
//
//  Created by Justin.Dombecki on 3/11/15.
//  Copyright (c) 2015 Justin.Dombecki. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        consumeExtensionContent()
        
        self.searchBar.becomeFirstResponder()
        self.searchBar.delegate = self
    }
    
    func loadWebViewWithDocument(document: String!, baseURL: NSURL!) {
        webView.loadHTMLString(document, baseURL: baseURL)
    }
    
    @IBAction func donePressed(sender: AnyObject) {
        exportExtensionContent()
    }
    
// MARK : UISearchBarDelegate
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    }
    
// MARK: Extension
    func consumeExtensionContent() {
        for item: AnyObject in self.extensionContext!.inputItems {
            println("\(item)")
            let inputItem = item as! NSExtensionItem
            for provider: AnyObject in inputItem.attachments! {
                let itemProvider = provider as! NSItemProvider
                let providedTypeIdentifiers = itemProvider.registeredTypeIdentifiers
                for identifier in providedTypeIdentifiers {
                    itemProvider.loadItemForTypeIdentifier(identifier as! String, options: nil, completionHandler:{ (object, error) in
                        if error != nil {
                            println("\(error)")
                        }
                        let dictionary = object as! NSDictionary
                        let userDictionary: AnyObject? = dictionary[NSExtensionJavaScriptPreprocessingResultsKey]
                        let document: AnyObject? = userDictionary!.valueForKey("document")
                        let baseURI: AnyObject? = userDictionary!.valueForKey("baseURI")
                        self.loadWebViewWithDocument(document as! String, baseURL: NSURL(string: baseURI as! String))
                    })
                }
            }
        }
    }
    
    func exportExtensionContent() {
        let extensionItem = NSExtensionItem()
        extensionItem.attachments = [NSItemProvider(item: [NSExtensionJavaScriptFinalizeArgumentKey:["string":self.searchBar.text]],
                                          typeIdentifier: kUTTypePropertyList as String)]
        self.extensionContext!.completeRequestReturningItems([extensionItem], completionHandler: nil)
    }
}
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
    @IBOutlet weak var searchBarBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        consumeExtensionContent()
        observeKeyboardNotifications()

        self.searchBar.becomeFirstResponder()
        self.searchBar.delegate = self
    }
    
// MARK : UISearchBarDelegate
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        exportExtensionContent()
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
                        println("have the kUTTypePropertyList propertyList \(object)")
                        println("error \(error)")
                        let dictionary = object as! NSDictionary
                        let jsResultKeys: AnyObject? = dictionary[NSExtensionJavaScriptPreprocessingResultsKey]
//                        let object : AnyObject? = NSKeyedArchiver(NSDictionaty()).decodeObjectForKey(NSExtensionJavaScriptPreprocessingResultsKey)
                        if let itIsObject: AnyObject = object {
                            let fileOpener = FileOpener()
                            if let fileJS = fileOpener.open("TagContentWrapper.js") {
                                let js = NSString(format: fileJS, "can")
                                
                                //                            self.webView.loadHTMLString(propertyList["document"], baseURL: propertyList["baseURI"])
                                let newHtml = self.webView.stringByEvaluatingJavaScriptFromString(js as String)
                                println("new html \(newHtml)")
                            }
                        }
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
    
// MARK: Keyboard
    
    func observeKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    func keyboardWillShow(notification: NSNotification) {
        var info = notification.userInfo!
        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.searchBarBottomConstraint.constant = keyboardFrame.size.height
        })
    }
    
    func keyboardWillHide(notification: NSNotification) {
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.searchBarBottomConstraint.constant = 0
        })
    }
}
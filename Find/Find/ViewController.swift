//
//  ViewController.swift
//  Find
//
//  Created by Justin.Dombecki on 2/11/15.
//  Copyright (c) 2015 Justin.Dombecki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeKeyboardNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func findButtonPressed(sender: UIButton) {
        var attributedString = Highlighter().highlight(textField.text, inString: textView.text)
        textView.attributedText = attributedString
    }

    @IBAction func backgroundTapped(sender: UITapGestureRecognizer) {
        textView.resignFirstResponder()
        textField.resignFirstResponder()
    }
    
    // MARK: Keyboard
    
    func observeKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardDidShow:"), name:UIKeyboardDidShowNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }

    func keyboardWillHide(notification: NSNotification) {
        bottomConstraint.constant = 0.0
        self.scrollToCursor()
    }
    
    func keyboardDidShow(notification: NSNotification) {
        let (endFrame, duration) = self.endFrameAndDurationFromKeyboardNotification(notification)
        UIView.animateWithDuration(duration) { () -> Void in
            self.bottomConstraint.constant = endFrame.height
        }
        self.scrollToCursor()
    }
    
    func endFrameAndDurationFromKeyboardNotification(notification: NSNotification) -> (CGRect, NSTimeInterval) {
        var info = notification.userInfo!
        let keyboardEndFrameValue = info[UIKeyboardFrameEndUserInfoKey] as! NSValue
        let keyboardAnimationDuration = info[UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        return (keyboardEndFrameValue.CGRectValue(), keyboardAnimationDuration)
    }

    func scrollToCursor () {
        // toggle scroll enabled,
        // shouldn't have to do this
        textView.scrollEnabled = false;
        textView.scrollRangeToVisible(textView.selectedRange)
        textView.scrollEnabled = true;
    }
}


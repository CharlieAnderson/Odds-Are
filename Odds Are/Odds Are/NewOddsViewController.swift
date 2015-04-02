//
//  NewOddsViewController.swift
//  Odds Are
//
//  Created by Jack Arendt on 3/29/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

import UIKit

class NewOddsViewController: UIViewController, UISearchBarDelegate, UITextViewDelegate {

    private let searchBar = UISearchBar()
    private let submit = UIButton()
    private let textView = UITextView()
    private let placeholder = UILabel()
    
    private var height : CGFloat = 0
    private var width  : CGFloat = 0
    private let utility  = OAUtility()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        
        navigationItem.title = "New Challenge"
        height = view.bounds.size.height
        width = view.bounds.size.width
        let gradient = utility.sunriseGradient(height, width: width, rotated: true)
        view = gradient
        view.backgroundColor = UIColor.whiteColor()
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancel")
        cancelButton.tintColor = utility.sunriseRed
        navigationItem.leftBarButtonItem = cancelButton
        
        
        submit.frame = CGRectMake(0, height - 44, width, 44)
        submit.backgroundColor = utility.sunriseRed
        submit.setTitle("Submit Challenge", forState: .Normal)
        submit.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        submit.setTitleColor(utility.lightRed, forState: .Highlighted)
        submit.addTarget(self, action: "submitOdds", forControlEvents: .TouchUpInside)
        view.addSubview(submit)

        
        let v = UIView(frame: CGRectMake(0, 64, width, 44))
        v.backgroundColor = UIColor.whiteColor()
        searchBar.frame = v.bounds
        searchBar.delegate = self
        searchBar.barTintColor = UIColor.whiteColor()
        searchBar.tintColor = utility.sunriseRed
        searchBar.translucent = false
        searchBar.placeholder = "Choose Recipient"
        searchBar.becomeFirstResponder()
        v.addSubview(searchBar)
        view.addSubview(v)
        
        let textViewOffset = v.frame.origin.y + v.bounds.size.height
        let textViewHeight = submit.frame.origin.y - textViewOffset
        textView.frame =  CGRectMake(0, textViewOffset, width, textViewHeight)
        textView.font = UIFont(name: utility.lightFont, size: 17.0)
        textView.textColor = utility.darkGrey
        textView.tintColor = utility.sunriseRed
        textView.delegate = self
        view.addSubview(textView)
        
        placeholder.frame = CGRectMake(5, textViewOffset + 3, width, 30)
        placeholder.text = "What's your challenge?"
        placeholder.textColor = UIColor.lightGrayColor()
        placeholder.font = UIFont(name: utility.lightFont, size: 17.0)
        view.addSubview(placeholder)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cancel() {
        searchBar.resignFirstResponder()
        textView.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func submitOdds() {
        searchBar.resignFirstResponder()
        textView.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: Keyboard functions
    func keyboardWillShow(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size.height {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.submit.frame = CGRectMake(0, self.height - keyboardHeight - 44, self.width, 44)
                    let textViewOffset : CGFloat = 108.0
                    let textViewHeight = self.submit.frame.origin.y - textViewOffset
                    self.textView.frame =  CGRectMake(0, textViewOffset, self.width, textViewHeight)
                })
            }
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.submit.frame = CGRectMake(0, self.height - 44, self.width, 44)
            let textViewOffset : CGFloat = 108.0
            let textViewHeight = self.submit.frame.origin.y - textViewOffset
            self.textView.frame =  CGRectMake(0, textViewOffset, self.width, textViewHeight)
        })

    }
    
    func keyboardWillChangeFrame(sender: NSNotification) {
        if let userInfo = sender.userInfo {
            if let keyboardHeight = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size.height {
                UIView.animateWithDuration(0.15, animations: { () -> Void in
                    self.submit.frame = CGRectMake(0, self.height - keyboardHeight - 44, self.width, 44)
                    let textViewOffset : CGFloat = 108.0
                    let textViewHeight = self.submit.frame.origin.y - textViewOffset
                    self.textView.frame =  CGRectMake(0, textViewOffset, self.width, textViewHeight)
                })
            }
        }

    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if range.location == 0 && range.length == 1 {
            view.addSubview(placeholder)
        }
        
        else if text != ""{
            placeholder.removeFromSuperview()
        }
        
        print(text)
        
        return true
        
    }
}

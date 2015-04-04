//
//  LoginViewController.swift
//  Odds Are
//
//  Created by Jack Arendt on 3/21/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    private var height : CGFloat = 0
    private var width  : CGFloat = 0
    private let utility  = OAUtility()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        height = view.bounds.size.height
        width = view.bounds.size.width
        let gradient = utility.sunriseGradient(height, width: width, rotated: true)
        view = gradient
        let logo = UIImageView(frame: CGRectMake(width * 0.25, height * 0.20, width * 0.5, width * 0.5))
        logo.image = UIImage(named: "logowhitegradient_full")
        view.addSubview(logo)
        
        
        let nameOffset = height * 0.20 + width * 0.5 + 10
        let name = UILabel(frame: CGRectMake(width * 0.1, nameOffset, width * 0.8, 60))
        name.text = "ODDS ARE"
        name.textColor = UIColor.whiteColor()
        name.textAlignment = .Center
        name.font = UIFont(name: utility.titleFont, size: 60)
        name.minimumScaleFactor = 0.7
        name.adjustsFontSizeToFitWidth = true
        view.addSubview(name)
        
        let loginButton = UIButton(frame: CGRectMake(width * 0.1, height * 0.8, width * 0.8, 50))
        loginButton.setImage(UIImage(named: "login_with_facebook"), forState: .Normal)
        loginButton.setImage(UIImage(named: "login_with_facebook_pressed"), forState: .Highlighted)
        loginButton.addTarget(self, action: "login", forControlEvents: .TouchUpInside)
        view.addSubview(loginButton)
        
//        let loginView = FBSDKLoginButton(frame: CGRectMake(width * 0.1, height * 0.8, width * 0.8, 50))
//        loginView.delegate = self
//        loginView.readPermissions = utility.facebookPermissions
//        view.addSubview(loginView)
        
        let sep = UIView(frame: CGRectMake(10, height - 30, width - 20, 1))
        sep.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(sep)
        
        let learnMoreButton = UIButton(frame: CGRectMake(0, height - 30, width, 30))
        learnMoreButton.setTitle("What is Odds Are?", forState: .Normal)
        learnMoreButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        learnMoreButton.setTitleColor(UIColor.lightGrayColor(), forState: .Highlighted)
        learnMoreButton.addTarget(self, action: "learnMore", forControlEvents: .TouchUpInside)
        learnMoreButton.titleLabel?.font = UIFont.systemFontOfSize(13.0)
        view.addSubview(learnMoreButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func login() {
        OASession.sharedSession.login({
            (newUser : Bool!, error : NSError?) in
            self.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    
    func learnMore() {
        
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        OASession.sharedSession.login({
            (newUser : Bool!, error : NSError?) in
            self.login()
        })
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

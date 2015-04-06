//
//  OAUtility.swift
//  Odds Are
//
//  Created by Jack Arendt on 3/21/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

import UIKit

class OAUtility : NSObject {
    
    //This is a higher level view of a challenge (used mainly in UI)
    enum OddsStage {
        case NeedsApproval  //used when you propose odds, but need it to be accepted
        case InProgress     //used when a challenge is in progress, but not completed
        case Completed      //used when a challenge is completed, but no photo or video
        case VideoPresent   //used when a challenge is completed, and a video is present
        case PhotoPresent   //used when a challenge is completed, and a photo is present
        case NotSuccessful  //used when a challenge is completed, but not successful
    }
    
    //This is for individual stages of a challenge (used mainly for parse to keep track
    //of where a challenge is in terms of progress)
    enum ChallengeStage: String {
        case ChallengeSubmitted = "challenge_submitted"
        case OddsSet            = "odds_set"
        case ChallengeeSetOdds  = "challengee_set_odds"
        case ChallengerSetOdds  = "challenger_set_odds"
        case WaitingForResult   = "waiting_for_result"
    }
    
    
    let sunriseRed      = UIColor(red: 0.964, green: 0.278, blue: 0.278, alpha: 1)
    let lightRed        = UIColor(red: 1, green: 0.3882, blue: 0.3882, alpha: 1)
    let sunriseOrange   = UIColor(red: 0.941, green: 0.655, blue: 0.2039, alpha: 1)
    let darkGrey        = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
    let lightGrey       = UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1)
    let approvalGreen   = UIColor(red: 0.0627, green: 0.6980, blue: 0.2431, alpha: 1)
    
    let titleFont   = "Neou-Bold"
    let lightFont   = "HelveticaNeue-Light"
    let font        = "HelveticaNeue"
    let boldFont    = "HelveticaNeue-Bold"
    
    let facebookPermissions = ["public_profile", "email", "user_friends"]
    let userDidLogOutNotification = "logoutNotification"
    let statusBarChangeNotification = "statusBarChange"
    
    override init() {
        super.init()
    }
    
    func sunriseGradient(height:CGFloat, width:CGFloat, rotated: Bool) -> UIView {
        let gradientView = UIView(frame: CGRectMake(0, 0, width, height))
        let gradient = CAGradientLayer()
        
        gradient.frame = gradientView.bounds
        if rotated {
            gradient.colors = [sunriseOrange.CGColor, sunriseRed.CGColor]
        }
        else {
            gradient.colors = [sunriseRed.CGColor, sunriseOrange.CGColor]
        }
        
        gradientView.layer.insertSublayer(gradient, atIndex: 0)
        return gradientView
    }
    
    func tableFooterView(title : String?, width : CGFloat, height : CGFloat) -> UIView {
        let v = UIView(frame: CGRectMake(0, 0, width, 80))
        let iv = UIImageView(image: UIImage(named: "logo_white_gradient"))
        iv.frame = CGRectMake(width/2 - 20, 10, 40, 40)
        v.addSubview(iv)
        
        if let t = title {
            let label = UILabel(frame: CGRectMake(0, 5, width, 20))
            label.text = t
            label.textAlignment = .Center
            label.textColor = UIColor.whiteColor()
            label.font = UIFont.systemFontOfSize(13.0)
            iv.frame = CGRectMake(width/2 - 20, 30, 40, 40)
            v.addSubview(label)
        }
        return v
    }
    
    func gradientCircleForSize(size : CGSize, text : String?, isImage: Bool) -> UIView {
        let v = sunriseGradient(size.height, width: size.width, rotated: false)
        v.layer.cornerRadius = size.height/2
        v.clipsToBounds = true
        
        if isImage == false {
            let label = UILabel(frame: CGRectMake(0, 0, size.width, size.height))
            label.textAlignment = .Center
            if let t = text {
                label.text = t
            }
            else {
                label.text = "?"
            }
            label.textColor = UIColor.whiteColor()
            label.font = UIFont(name: lightFont, size: size.width * 0.6)
            v.addSubview(label)
        }

        return v
    }

}

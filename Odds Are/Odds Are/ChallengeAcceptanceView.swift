//
//  ChallengeAcceptanceView.swift
//  Odds Are
//
//  Created by Jack Arendt on 4/6/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

import UIKit

protocol ChallengeAcceptanceViewDelegate {
    func acceptedButtonPressed()
    func rejectedButtonPressed()
}

class ChallengeAcceptanceView: UIView {

    private let utility = OAUtility()
    private let height : CGFloat = 0
    private let width : CGFloat = 0
    
    private let challengeLabel = UILabel()
    private let acceptButton = UIButton()
    private let rejectButton = UIButton()
    
    var challenge : String? {
        didSet {
            challengeLabel.text = challenge
        }
    }
    
    var delegate : ChallengeAcceptanceViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        height = frame.size.height
        width = frame.size.width
        backgroundColor = UIColor.whiteColor()
        
        let sep = UIView(frame: CGRectMake(0, 0, width, 0.5))
        sep.backgroundColor = UIColor.lightGrayColor()
        addSubview(sep)
        
        challengeLabel.frame = CGRectMake(15, 15, width - 30, 3*height/8)
        challengeLabel.numberOfLines = 3
        challengeLabel.text = challenge
        challengeLabel.textAlignment = .Center
        challengeLabel.font = UIFont(name: utility.lightFont, size: 20.0)
        addSubview(challengeLabel)
        
        acceptButton.frame =  CGRectMake(width/8, height/2, width/4, width/4)
        acceptButton.setImage(UIImage(named: "checkmark"), forState: .Normal)
        acceptButton.setImage(UIImage(named: "checkmark_highlighted"), forState: .Highlighted)
        acceptButton.addTarget(self, action: "accepted", forControlEvents: .TouchUpInside)
        addSubview(acceptButton)
        
        rejectButton.frame = CGRectMake(5 * width/8, height/2, width/4, width/4)
        rejectButton.setImage(UIImage(named: "cross"), forState: .Normal)
        rejectButton.setImage(UIImage(named: "cross_highlighted"), forState: .Highlighted)
        rejectButton.addTarget(self, action: "rejected", forControlEvents: .TouchUpInside)
        addSubview(rejectButton)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func rejected() {
        if let d = delegate {
            d.rejectedButtonPressed()
        }
    }
    
    func accepted() {
        if let d = delegate {
            d.acceptedButtonPressed()
        }
    }

}

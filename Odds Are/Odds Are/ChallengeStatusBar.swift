//
//  ChallengeStatusBar.swift
//  Odds Are
//
//  Created by Jack Arendt on 4/5/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

import UIKit

class ChallengeStatusBar: UIView {
    
    private let utility = OAUtility()
    private let height : CGFloat = 0
    private let width : CGFloat = 0
    private let statusLabel = UILabel()
    private let highlightView : UIView!
    private var isAnimating = false
    
    var status : String? {
        didSet {
            statusLabel.text = status
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        height = frame.size.height
        width = frame.size.width
        backgroundColor = utility.lightGrey
        
        
        highlightView = UIView(frame: CGRectMake(width/2, 0, 0, height))
        addSubview(highlightView)
        
        statusLabel.frame = self.bounds
        statusLabel.textColor = utility.darkGrey
        statusLabel.textAlignment = .Center
        statusLabel.font = UIFont(name: utility.lightFont, size: 14.0)
        addSubview(statusLabel)
        

    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func animateStatus(newStatus : String?, highlightColor : UIColor, completion: (finished: Bool) -> ()) {
        if isAnimating {
            completion(finished: true)
            return
        }
        statusLabel.textColor = utility.lightGrey
        highlightView.backgroundColor = highlightColor
        highlightView.frame = CGRectMake(width/2, 0, 0, height)
        highlightView.alpha = 1
        isAnimating = true
        
        UIView.animateKeyframesWithDuration(0.8, delay: 0, options: .AllowUserInteraction, animations: {
            self.highlightView.frame = CGRectMake(0, 0, self.width, self.height)
            }, completion: {(success : Bool) in
                self.statusLabel.textColor = self.utility.darkGrey
                self.statusLabel.alpha = 0
                self.statusLabel.text = newStatus
                completion(finished: false)
                UIView.animateKeyframesWithDuration(2.5, delay: 0, options: .AllowUserInteraction, animations: {
                    self.highlightView.alpha = 0
                    self.statusLabel.alpha = 1
                    }, completion: {(success : Bool) in
                        self.isAnimating = false
                        completion(finished: true)
                })
        })
    }
}

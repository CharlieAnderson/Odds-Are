//
//  ChallengeViewController.swift
//  Odds Are
//
//  Created by Jack Arendt on 4/1/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

import UIKit

class ChallengeViewController: UIViewController, ChallengeAcceptanceViewDelegate {

    private let utility = OAUtility()
    private var height : CGFloat = 0
    private var width  : CGFloat = 0
    
    var statusBar : ChallengeStatusBar!
    var challengeAcceptanceView : ChallengeAcceptanceView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        width = view.bounds.size.width
        height = view.bounds.size.height
        view = utility.sunriseGradient(height, width: width, rotated: true)
        
        navigationItem.titleView = navigationTitle()
        
        statusBar = ChallengeStatusBar(frame: CGRectMake(0, 0, width, 30))
        statusBar.status = "Needs Approval"
        view.addSubview(statusBar)
        
        challengeAcceptanceView = ChallengeAcceptanceView(frame: CGRectMake(0, 30, width, 0.64 * width))
        challengeAcceptanceView.challenge = "Go to Starbucks and get me the largest drink they have."
        challengeAcceptanceView.delegate = self
        view.addSubview(challengeAcceptanceView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Challenge View Delegate Methods
    func rejectedButtonPressed() {
        highlight(utility.sunriseRed, title: "Challenge Rejected")
    }
    
    func acceptedButtonPressed() {
        highlight(utility.approvalGreen, title: "Challenge Accepted")
    }
    
    
    func highlight(color : UIColor, title: String) {
        statusBar.animateStatus(title, highlightColor: color, completion: { (finished : Bool) in
            if !finished {
                
            }
        })
    }
    
    func navigationTitle() -> UIView {
        let v = UIView(frame: CGRectMake(0, 0, width - 100, 44))
        let image = UIImageView(image: UIImage(named: "profile"))
        image.frame = CGRectMake(0, 0, 35, 35)
        image.layer.cornerRadius = image.bounds.size.height/2
        image.clipsToBounds = true
        
        
        let font = UIFont(name: utility.font, size: 21.0)
        let name = "Leah V"

        let nameLabel = UILabel(frame: CGRectMake(50, 0, 200, 40))
        nameLabel.text = name
        nameLabel.font = font
        nameLabel.sizeToFit()
        nameLabel.center = CGPointMake(nameLabel.center.x, image.center.y)
        
        v.addSubview(image)
        v.addSubview(nameLabel)
        v.frame = CGRectMake(0, 0, nameLabel.frame.origin.x + nameLabel.frame.size.width, 44)
        return v
    }
}

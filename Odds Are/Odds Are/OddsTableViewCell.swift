//
//  OddsTableViewCell.swift
//  Odds Are
//
//  Created by Jack Arendt on 3/25/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

import UIKit

class OddsTableViewCell: UITableViewCell {

    var name : String? {
        didSet {
            updateCellAttributes()
        }
    }
    
    var challenge : String? {
        didSet {
            updateCellAttributes()
        }
    }
    
    var profileImage : UIImage? {
        didSet {
            updateCellAttributes()
        }
    }
    
    var odds : Int? {
        didSet {
            updateCellAttributes()
        }
    }
    
    var theirOdds : Int? {
        didSet {
            updateCellAttributes()
        }
    }
    
    var yourOdds : Int? {
        didSet {
            updateCellAttributes()
        }
    }
    
    var lastUpdated : String? {
        didSet {
            updateCellAttributes()
        }
    }
    
    var OddsStage : OAUtility.OddsStage? {
        didSet {
            updateCellAttributes()
        }
    }
    
    private let utility = OAUtility()
    private var height  : CGFloat = 0
    private var width   : CGFloat = 0
    private let circleSize = CGSizeMake(30, 30)
    
    private let nameLabel           = UILabel()
    private let profileImageView    = UIImageView()
    private let challengeLabel      = UILabel()
    private let statusImage         = UIImageView()
    private let lastUpdatedLabel    = UILabel()
    
    private var chosenOddsView  : CircleGradientView!
    private var yourOddsView    : CircleGradientView!
    private var theirOddsView   : CircleGradientView!
    private var statusView      : CircleGradientView!
    
    private let chosenOddsTitle : UILabel!
    private let yourOddsTitle   : UILabel!
    private let theirOddsTitle   : UILabel!
    private let statusTitle     : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryType = .DisclosureIndicator
        
        chosenOddsView  = CircleGradientView(frame: CGRectMake(0, 0, circleSize.width, circleSize.height))
        yourOddsView    = CircleGradientView(frame: CGRectMake(0, 0, circleSize.width, circleSize.height))
        theirOddsView   = CircleGradientView(frame: CGRectMake(0, 0, circleSize.width, circleSize.height))
        statusView      = CircleGradientView(frame: CGRectMake(0, 0, circleSize.width, circleSize.height))

        
        chosenOddsTitle = createOddsTitles("Odds")
        yourOddsTitle   = createOddsTitles("Yours")
        theirOddsTitle  = createOddsTitles("Theirs")
        statusTitle     = createOddsTitles("Status")
        
        addSubview(chosenOddsView)
        addSubview(yourOddsView)
        addSubview(theirOddsView)
        addSubview(statusView)
        addSubview(nameLabel)
        
        addSubview(profileImageView)
        addSubview(challengeLabel)
        addSubview(lastUpdatedLabel)
    }
    
    func createOddsTitles(text : String) -> UILabel {
        let label = UILabel()
        label.bounds = CGRectMake(0, 0, 60, 15)
        label.text = text
        label.font = UIFont(name: utility.lightFont, size: 11.0)
        label.textColor = UIColor.lightGrayColor()
        label.textAlignment = .Center
        addSubview(label)
        return label
    }
    
    func updateCellAttributes() {
        height = bounds.size.height
        width = bounds.size.width
        
        if let o = odds {
            chosenOddsView.value = String(o)
        }

        if let t = theirOdds {
            theirOddsView.value = String(t)
        }

        if let y = yourOdds {
            yourOddsView.value = String(y)
        }
        setOddsStatus()
        
        chosenOddsView.center = CGPointMake(width * 0.1, height * 3/4)
        chosenOddsTitle.center = CGPointMake(width * 0.1, height * 15/16)
        
        yourOddsView.center = CGPointMake(width * 0.28, height * 3/4)
        yourOddsTitle.center = CGPointMake(width * 0.28, height * 15/16)
        
        theirOddsView.center = CGPointMake(width * 0.46, height * 3/4)
        theirOddsTitle.center = CGPointMake(width * 0.46, height * 15/16)
        
        statusView.center   = CGPointMake(width - 67.5, height * 3/4)
        statusTitle.center  = CGPointMake(width - 67.5, height * 15/16)
        
        nameLabel.text = name
        nameLabel.frame = CGRectMake(70, 20, width * 0.72, 25)
        nameLabel.font = UIFont.systemFontOfSize(20.0)
        
        profileImageView.image = profileImage
        profileImageView.frame = CGRectMake(15, 15, 45, 45)
        profileImageView.layer.cornerRadius = profileImageView.bounds.size.height/2
        profileImageView.clipsToBounds = true
        
        challengeLabel.text = challenge
        challengeLabel.frame = CGRectMake(70, 45, width * 0.72, 15)
        challengeLabel.textColor = UIColor.grayColor()
        challengeLabel.font = UIFont(name: utility.lightFont, size: 13)
        
        lastUpdatedLabel.text = lastUpdated
        lastUpdatedLabel.bounds = CGRectMake(0, 0, 75, 20)
        lastUpdatedLabel.center = CGPointMake(statusView.center.x, 35)
        lastUpdatedLabel.textAlignment = .Center
        lastUpdatedLabel.textColor = UIColor.darkGrayColor()
        lastUpdatedLabel.font = UIFont(name: utility.lightFont, size: 12)
        
        statusImage.bounds = CGRectMake(0, 0, 22, 22)
        statusImage.center = statusView.center
    }
    
    func setLabelAttributes(label : UILabel, x : CGFloat, y : CGFloat) {
        label.bounds = CGRectMake(0, 0, 30, 30)
        label.center = CGPointMake(x, y)
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        label.font = UIFont(name: utility.lightFont, size: 18)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setOddsStatus() {
        if OddsStage == .NeedsApproval {
            statusView.value = "NA"
            statusView.containsImage = false
        }
        
        else if OddsStage == .InProgress {
            statusView.value = "IP"
            statusView.containsImage = false
        }
        
        else if OddsStage == .Completed {
            statusView.value = "C"
            statusView.containsImage = false
        }
        
        else if OddsStage == .NotSuccessful {
            statusView.value = "failed_white"
            statusView.containsImage = true
        }
        
        else if OddsStage == .PhotoPresent {
            statusView.value = "camera"
            statusView.containsImage = true
        }
        
        else if OddsStage == .VideoPresent {
            statusView.value = "video"
            statusView.containsImage = true
        }
        
        else {
            statusView.containsImage = false
        }
    }
}

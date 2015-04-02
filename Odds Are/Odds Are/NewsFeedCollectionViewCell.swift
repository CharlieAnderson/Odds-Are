//
//  NewsFeedCollectionViewCell.swift
//  Odds Are
//
//  Created by Jack Arendt on 3/26/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

import UIKit

class NewsFeedCollectionViewCell: UICollectionViewCell {
    
    
    var challengerName  : String? {
        didSet {
            updateCellAttributes()
        }
    }
    var challengerImage : UIImage? {
        didSet {
            updateCellAttributes()
        }
    }
    var challengeeName  : String? {
        didSet {
            updateCellAttributes()
        }
    }
    var challengeeImage : UIImage? {
        didSet {
            updateCellAttributes()
        }
    }
    var chosenOdds      : Int? {
        didSet {
            updateCellAttributes()
        }
    }
    var challengerOdds  : Int? {
        didSet {
            updateCellAttributes()
        }
    }
    var challengeeOdds  : Int? {
        didSet {
            updateCellAttributes()
        }
    }
    var challenge       : String? {
        didSet {
            updateCellAttributes()
        }
    }
    var time            : String? {
        didSet {
            updateCellAttributes()
        }
    }
    var date            : String? {
        didSet {
            updateCellAttributes()
        }
    }

    var OddsStage       : OAUtility.OddsStage? {
        didSet {
            updateCellAttributes()
        }
    }
    
    
    private let challengerLabel      = UILabel()
    private let challengerImageView  = UIImageView()
    private let challengeeLabel      = UILabel()
    private let challengeeImageView  = UIImageView()
    private let chosenOddsLabel      = UILabel()
    private var challengerOddsView   : CircleGradientView!
    private var challengeeOddsView   : CircleGradientView!
    private let challengeLabel       = UILabel()
    private let timeLabel            = UILabel()
    private let dateLabel            = UILabel()
    private let challengeStatusLabel = UILabel()
    private let challengeStatusImage = UIImageView()
    private let statusLabel          = UILabel()
    private let statusImage          = UIImageView()
    
    private let utility = OAUtility()
    private var height  : CGFloat = 0
    private var width   : CGFloat = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        layer.borderColor = UIColor.lightGrayColor().CGColor
        layer.borderWidth = 1.0
        height = bounds.size.height
        width = bounds.size.width
        
        
        challengerImageView.frame = CGRectMake(0.1126 * width, 0.028 * width, 0.169 * width, 0.169 * width)
        challengerImageView.layer.cornerRadius = challengerImageView.bounds.size.height/2
        challengerImageView.clipsToBounds = true
        addSubview(challengerImageView)
        
        challengerLabel.bounds = CGRectMake(0, 0, 0.2112 * width, 0.0711 * height)
        challengerLabel.center = CGPointMake(challengerImageView.center.x, 0.3022 * height)
        challengerLabel.textAlignment = .Center
        challengerLabel.font = UIFont(name: utility.boldFont, size: 0.045 * width)
        addSubview(challengerLabel)
        
        challengeeImageView.frame = CGRectMake(0.7183 * width, 0.028 * width, 0.169 * width, 0.169 * width)
        challengeeImageView.layer.cornerRadius = challengeeImageView.bounds.size.height/2
        challengeeImageView.clipsToBounds = true
        addSubview(challengeeImageView)
        
        challengeeLabel.bounds = CGRectMake(0, 0, 0.2112 * width, 0.0711 * height)
        challengeeLabel.center = CGPointMake(challengeeImageView.center.x, 0.3022 * height)
        challengeeLabel.textAlignment = .Center
        challengeeLabel.font = UIFont(name: utility.boldFont, size: 0.045 * width)
        addSubview(challengeeLabel)
        
        chosenOddsLabel.bounds = CGRectMake(0, 0, 0.2253 * width, 0.2133 * height)
        chosenOddsLabel.center = CGPointMake(width/2, challengeeImageView.center.y)
        chosenOddsLabel.textAlignment = .Center
        chosenOddsLabel.textColor = utility.sunriseRed
        chosenOddsLabel.font = UIFont(name: utility.font, size: 0.1408 * width)
        addSubview(chosenOddsLabel)
        
        let challengedLabel = UILabel(frame: CGRectMake(0, 0, 0.2817 * width, 0.0711 * height))
        challengedLabel.center = CGPointMake(width/2, challengerLabel.center.y)
        challengedLabel.text = "challenged"
        challengedLabel.textColor = utility.darkGrey
        challengedLabel.textAlignment = .Center
        challengedLabel.font = UIFont(name: utility.lightFont, size: 0.0422 * width)
        addSubview(challengedLabel)
        
        let topSep = UIView(frame: CGRectMake(10, 0.3556 * height, width - 20, 1))
        topSep.backgroundColor = UIColor.lightGrayColor()
        addSubview(topSep)
        
        
        challengerOddsView = CircleGradientView(frame: CGRectMake(0, 0, 0.1831 * width, 0.1831 * width))
        challengerOddsView.center = CGPointMake(challengerImageView.center.x, height/2)
        addSubview(challengerOddsView)
        
        challengeeOddsView = CircleGradientView(frame: CGRectMake(0, 0, 0.1831 * width, 0.1831 * width))
        challengeeOddsView.center = CGPointMake(challengeeImageView.center.x, height/2)
        addSubview(challengeeOddsView)
        
        let topMiddleSep = UIView(frame: CGRectMake(10, 0.6401 * height, width - 20, 1))
        topMiddleSep.backgroundColor = UIColor.lightGrayColor()
        addSubview(topMiddleSep)
        
        challengeLabel.frame = CGRectMake(15, 0.6757 * height, width - 30, 0.0711 * height)
        challengeLabel.font = UIFont(name: utility.lightFont, size: 0.0479 * height)
        challengeLabel.minimumScaleFactor = 0.5
        challengeLabel.adjustsFontSizeToFitWidth = true
        addSubview(challengeLabel)
        
        timeLabel.frame = CGRectMake(15, 0.7468 * height, 0.169 * width, 0.0711 * height)
        timeLabel.font = UIFont(name: utility.boldFont, size: 0.0394 * width)
        addSubview(timeLabel)
        
        dateLabel.frame = CGRectMake(0.169 * width + 15, 0.7468 * height, 0.7183 * width, 0.0711 * height)
        dateLabel.font = UIFont(name: utility.lightFont, size: 0.0394 * width)
        addSubview(dateLabel)
        
        let botMiddleSep = UIView(frame: CGRectMake(10, 0.8534 * height, width - 20, 1))
        botMiddleSep.backgroundColor = UIColor.lightGrayColor()
        addSubview(botMiddleSep)
        
        statusLabel.font = UIFont(name: utility.lightFont, size: 0.0451 * width)
        addSubview(statusLabel)
        statusImage.frame = CGRectMake(15, 0.889 * height, 0.0563 * width, 0.0711 * height)
        addSubview(statusImage)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateCellAttributes() {
        challengerImageView.image = challengerImage
        challengerLabel.text = challengerName
        challengeeImageView.image = challengeeImage
        challengeeLabel.text = challengeeName
        
        if let c = chosenOdds {
            chosenOddsLabel.text = String(c)
        }
        
        if let challengerO = challengerOdds {
            challengerOddsView.value = String(challengerO)
        }
        if let challengeeO = challengeeOdds {
            challengeeOddsView.value = String(challengeeO)
        }
        
        challengeLabel.text = challenge
        timeLabel.text = time
        dateLabel.text = date
        
        determineStage()
        
    }
    
    func determineStage() {
        if OddsStage == .NeedsApproval {
            statusLabel.text = "Needs Approval"
            statusImage.hidden = true
            statusLabel.frame = CGRectMake(15, 0.889 * height, width - 30, 0.0711 * height)
        }
        
        else if OddsStage == .InProgress {
            statusLabel.text = "In Progress"
            statusImage.hidden = true
            statusLabel.frame = CGRectMake(15, 0.889 * height, width - 30, 0.0711 * height)
        }
            
        else if OddsStage == .Completed {
            statusLabel.text = "Odds Successful"
            statusImage.hidden = true
            statusLabel.frame = CGRectMake(15, 0.889 * height, width - 30, 0.0711 * height)
        }
            
        else if OddsStage == .NotSuccessful {
            statusLabel.text = "Odds Not Successful"
            statusImage.hidden = false
            statusLabel.frame = CGRectMake(0.0563 * width + 20, 0.889 * height, width - 30, 0.0711 * height)
            statusImage.image = UIImage(named: "failed_black")
        }
            
        else if OddsStage == .PhotoPresent {
            statusLabel.text = "Click to view photo"
            statusImage.hidden = false
            statusLabel.frame = CGRectMake(0.0563 * width + 20, 0.889 * height, width - 30, 0.0711 * height)
            statusImage.image = UIImage(named: "camera_black")
        }
            
        else if OddsStage == .VideoPresent {
            statusLabel.text = "Click to view video"
            statusImage.hidden = false
            statusLabel.frame = CGRectMake(0.0563 * width + 20, 0.889 * height, width - 30, 0.0711 * height)
            statusImage.image = UIImage(named: "video_black")
        }
            
        else {
            statusLabel.text = ""
            statusImage.hidden = true
            statusLabel.frame = CGRectMake(15, 0.889 * height, width - 30, 0.0711 * height)
        }
    }
}

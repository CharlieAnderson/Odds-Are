//
//  StatisticsTableViewCell.swift
//  Odds Are
//
//  Created by Jack Arendt on 3/25/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

import UIKit

class StatisticsTableViewCell: UITableViewCell {

    var statName : String? {
        didSet {
            updateCellValues()
        }
    }
    
    var statValue : Int? {
        didSet {
            updateCellValues()
        }
    }
    
    private var height  : CGFloat = 0
    private var width   : CGFloat = 0
    private let utility  = OAUtility()
    
    private let nameLabel = UILabel()
    private let statLabel = UILabel()
    
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
        selectionStyle = .None
        
        nameLabel.textColor = utility.darkGrey
        nameLabel.font = UIFont.systemFontOfSize(16.0)
        addSubview(nameLabel)
        
        statLabel.textColor = utility.sunriseRed
        statLabel.textAlignment = .Center
        addSubview(statLabel)
        
        updateCellValues()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateCellValues() {
        height = bounds.size.height
        width = bounds.size.width
        
        nameLabel.text = statName
        nameLabel.frame = CGRectMake(15, 0, 2*width/3, height)
        
        statLabel.frame = CGRectMake(width/2, 0, width/2, height)
        if let value = statValue {
            statLabel.text = String(value)
        }
        statLabel.font = UIFont(name: utility.lightFont, size: height * 0.7)
    }
    
    // TODO: handle animation and slides

}

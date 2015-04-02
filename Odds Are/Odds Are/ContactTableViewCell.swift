//
//  ContactTableViewCell.swift
//  Odds Are
//
//  Created by Jack Arendt on 3/25/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    var name : String? {
        didSet {
            updateCellValues()
        }
    }
    
    var lastUsed : String? {
        didSet {
            updateCellValues()
        }
    }
    
    var profileImage : UIImage? {
        didSet {
            updateCellValues()
        }
    }
    
    private var height  : CGFloat = 0
    private var width   : CGFloat = 0
    private let utility  = OAUtility()

    private let nameLabel = UILabel()
    private let lastUsedLabel = UILabel()
    private let profileImageView = UIImageView()
    
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
        addSubview(nameLabel)
        addSubview(lastUsedLabel)
        addSubview(profileImageView)
        updateCellValues()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateCellValues() {
        height = bounds.size.height
        width = bounds.size.width
        alpha = 1.0
        
        profileImageView.image = profileImage
        profileImageView.frame = CGRectMake(15, height * 0.1 , height * 0.8, height * 0.8)
        profileImageView.layer.cornerRadius = height * 0.4
        profileImageView.clipsToBounds = true
        
        nameLabel.text = name
        nameLabel.frame = CGRectMake(height * 1.3, 0, width - height*1.3 - 30, height * 0.7)
        nameLabel.textColor = UIColor.blackColor()
        nameLabel.font = UIFont(name: utility.font, size: 17.0)
        
        lastUsedLabel.text = lastUsed
        lastUsedLabel.frame = CGRectMake(height * 1.3, height * 0.4, width - height*1.3 - 30, height * 0.6)
        lastUsedLabel.textColor = UIColor.grayColor()
        lastUsedLabel.font = UIFont(name: utility.lightFont, size: 12.0)
    }

}

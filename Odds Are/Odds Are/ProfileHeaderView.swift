//
//  ProfileHeaderView.swift
//  Odds Are
//
//  Created by Jack Arendt on 3/25/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {
    
    var profileImage : UIImage? {
        didSet {
            profileImageView.image = profileImage
        }
    }
    
    var name : String? {
        didSet {
            profileName.text = name
        }
    }
    
    var title : String? {
        didSet {
            profileTitle.text = title
        }
    }
    
    private let profileImageView = UIImageView()
    private let profileName = UILabel()
    private let profileTitle = UILabel()
    
    private var height : CGFloat = 0.0
    private var width : CGFloat = 0.0
    
    private let utility = OAUtility()

    override init(frame: CGRect) {
        super.init(frame: frame)
        height = bounds.size.height
        width = bounds.size.width
        createView()
        
        addSubview(profileImageView)
        addSubview(profileName)
        addSubview(profileTitle)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createView() {
        backgroundColor = UIColor.clearColor()
        let diameter : CGFloat = width * 100.0/375.0
        profileImageView.frame = CGRectMake(width/2 - diameter/2, 20, diameter, diameter)
        profileImageView.image = profileImage
        profileImageView.layer.cornerRadius = diameter/2
        profileImageView.clipsToBounds = true
        
        profileName.frame = CGRectMake(10, diameter + 30, width - 20, 30)
        profileName.text = name
        profileName.textColor = UIColor.whiteColor()
        profileName.textAlignment = .Center
        profileName.minimumScaleFactor = 0.5
        profileName.adjustsFontSizeToFitWidth = true
        profileName.font = UIFont.systemFontOfSize(25.0)
        
        profileTitle.frame = CGRectMake(10, diameter + 60, width - 20, 20)
        profileTitle.text = title
        profileTitle.textColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        profileTitle.textAlignment = .Center
        profileTitle.minimumScaleFactor = 0.5
        profileTitle.adjustsFontSizeToFitWidth = true
        profileTitle.font = UIFont(name: utility.lightFont, size: 16.0)
    }

}

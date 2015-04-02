//
//  CircleGradientView.swift
//  Odds Are
//
//  Created by Jack Arendt on 3/26/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

import UIKit

class CircleGradientView: UIView {
    
    var containsImage : Bool = false {
        didSet {
            updateCellAttributes()
        }
    }
    var value : String? {
        didSet {
            updateCellAttributes()
        }
    }
    
    private let utility = OAUtility()
    private let label = UILabel()
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = frame.size.height/2
        clipsToBounds = true
        
        let gradient = utility.sunriseGradient(frame.size.height, width: frame.size.width, rotated: false)
        addSubview(gradient)
        
        label.frame = frame
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        label.font = UIFont(name: utility.lightFont, size: frame.size.height * 0.6)
        addSubview(label)
        
        
        imageView.frame = CGRectMake(0, 0, 0.733 * frame.size.height, 0.733 * frame.size.height)
        imageView.center = center
        addSubview(imageView)
        
        updateCellAttributes()
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateCellAttributes() {
        if let v = value {
            label.text = v
            imageView.image = UIImage(named: v)
        }
        else {
            label.text = "?"
        }
        
        if containsImage {
            imageView.hidden = false
            label.hidden = true
        }
        else {
            imageView.hidden = true
            label.hidden = false
        }
    }
}

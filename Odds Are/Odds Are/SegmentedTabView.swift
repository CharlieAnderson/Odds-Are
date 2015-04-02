//
//  SegmentedTabView.swift
//  Odds Are
//
//  Created by Jack Arendt on 3/21/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

import UIKit

protocol SegmentedTabViewDelegate {
    func segmentedTabViewDidSelect(selected : Int)
    func segmentedTabViewFinishedAnimating()
}

class SegmentedTabView: UIView {

    // MARK: class variables
    var selectedIndex : Int = 0
    
    var titles : [String] = [String]() {
        didSet {
            createView()
            setTitleLabels()
        }
    }
    
    var delegate: SegmentedTabViewDelegate?
    
    private let slider = UIView()
    private var height : CGFloat = 0
    private var width  : CGFloat = 0
    
    private let utility = OAUtility()
    
    
    // MARK: initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = utility.lightGrey
        height = self.bounds.size.height
        width = self.bounds.size.width
        
        addSubview(slider)
        createView()
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: "moveSliderSwiped:")
        leftSwipe.direction = .Left
        addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: "moveSliderSwiped:")
        rightSwipe.direction = .Right
        addGestureRecognizer(rightSwipe)
        
        let sep = UIView(frame: CGRectMake(0, height - 0.5, width, 0.5))
        sep.backgroundColor = UIColor.lightGrayColor()
        addSubview(sep)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: helper functions
    private func createView() {
        let sliderWidth = (width/CGFloat(titles.count + 1))
        slider.bounds = CGRectMake(0, 0, sliderWidth, height * 0.1)
        slider.backgroundColor = utility.sunriseRed
        self.slider.center = CGPointMake(self.width/CGFloat(titles.count * 2), self.height * 0.8)
    }
    
    private func moveSlider(animated : Bool) {
        delegate?.segmentedTabViewDidSelect(selectedIndex)
        
        if !animated {
            moveSliderCenter()
            return
        }
        
        UIView.animateKeyframesWithDuration(0.2, delay: 0, options: .AllowUserInteraction, animations: {
            self.moveSliderCenter()
            }, { finished in
                if let d = self.delegate {
                    d.segmentedTabViewFinishedAnimating()
                }
            })
    }
    
    private func moveSliderCenter() {
        self.slider.center = CGPointMake(CGFloat(selectedIndex * 2 + 1) * self.width/CGFloat(titles.count * 2), self.height * 0.8)
    }
    
    private func setTitleLabels() {
        for var i = 0; i < titles.count; i++ {
            let label = UILabel(frame: CGRectMake((width/CGFloat(titles.count) * CGFloat(i)), 0, width/CGFloat(titles.count), height*0.9))
            label.text = titles[i]
            label.textAlignment = .Center
            label.font = UIFont(name: utility.lightFont, size: 16.0)
            addSubview(label)
        
            let button = UIButton(frame: CGRectMake((width/CGFloat(titles.count) * CGFloat(i)), 0, width/CGFloat(titles.count), height))
            button.addTarget(self, action: "moveSliderTapped:", forControlEvents: .TouchUpInside)
            button.tag = i
            addSubview(button)
        }
    }
    
    func setSliderIndex(index : Int, animated : Bool) {
        selectedIndex = index
        moveSlider(animated)
    }
    
    func moveSliderTapped(sender: UIButton!) {
        selectedIndex = sender.tag
        moveSlider(true)
    }
    
    func moveSliderSwiped(sender : UISwipeGestureRecognizer!) -> Bool{
        let orig = selectedIndex
        if sender.direction == .Right && selectedIndex > 0{
            selectedIndex--
            moveSlider(true)
        }
        else if sender.direction == .Left && selectedIndex < titles.count - 1{
            selectedIndex++
            moveSlider(true)
        }
        return !(selectedIndex == orig)
    }
}

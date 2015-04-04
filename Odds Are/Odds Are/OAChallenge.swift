//
//  OAChallenge.swift
//  Odds Are
//
//  Created by Jack Arendt on 4/3/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

import UIKit

class OAChallenge: PFObject, PFSubclassing {
    override class func initialize() {
        self.registerSubclass()
    }
    
    class func parseClassName() -> String! {
        return "Challenge"
    }
    
    @NSManaged var challenger : OAUser
    @NSManaged var challengee : OAUser
    @NSManaged var date : NSDate
    @NSManaged var challenge : String
    @NSManaged var setOdds : Int
    @NSManaged var challengerOdds : Int
    @NSManaged var challengeeOdds : Int
    @NSManaged var status : String
    @NSManaged var uploadedData : NSData
    @NSManaged var dataType : String
}

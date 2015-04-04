//
//  OAUser.swift
//  Odds Are
//
//  Created by Jack Arendt on 4/2/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

import UIKit

class OAUser: PFUser, PFSubclassing {
    override class func initialize(){
        self.registerSubclass()
    }
    
    func parseClassName() -> String! {
        return "User"
    }
    
    //My variables
    @NSManaged var name : String
    @NSManaged var firstName : String
    @NSManaged var lastName : String
    @NSManaged var gender : String
    @NSManaged var oddsTitle: String
    @NSManaged var facebookID : String
    @NSManaged var privateData : OAUserPrivateData
}

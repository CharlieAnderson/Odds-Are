//
//  OAUserPrivateData.swift
//  Odds Are
//
//  Created by Jack Arendt on 4/2/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

import UIKit

class OAUserPrivateData: PFObject, PFSubclassing {
    override class func initialize() {
        self.registerSubclass()
    }
    
    class func parseClassName() -> String! {
        return "UserPrivateData"
    }

    @NSManaged var userID: String
    @NSManaged var friends: [OAUser]
    @NSManaged var facebookFriends: [String]
    @NSManaged var deviceID: String
}

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
    
    func profileImage(completion: (image : UIImage) -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) { // 1
            let image = UIImage(data: self.profilePicture.getData()!)
            completion(image:image!)
        }
    }
    
    func profileImageOnMainQueue() -> UIImage! {
        return UIImage(data: self.profilePicture.getData())
    }
    
    //My variables
    @NSManaged var name : String
    @NSManaged var firstName : String
    @NSManaged var lastName : String
    @NSManaged var gender : String
    @NSManaged var oddsTitle: String
    @NSManaged var facebookID : String
    @NSManaged var profilePicture : PFFile
    @NSManaged var privateData : OAUserPrivateData
}

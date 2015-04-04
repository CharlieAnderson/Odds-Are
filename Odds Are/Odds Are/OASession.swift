//
//  OASession.swift
//  Odds Are
//
//  Created by Jack Arendt on 4/3/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

import UIKit

class OASession: NSObject {
    
    private let utility = OAUtility()
    
    override init() {
        super.init()
    }
   
    class var sharedSession: OASession {
        struct Singleton {
            static let instance = OASession()
        }
        return Singleton.instance
    }
    
    
    func login(completion : (newUser : Bool, err : NSError?) -> ()) {
        PFFacebookUtils.logInInBackgroundWithReadPermissions(utility.facebookPermissions, block: {
            (user: PFUser!, error: NSError!) -> Void in
            if let user = user {
                if user.isNew {
                    println("User signed up and logged in through Facebook!")
                    self.syncForNewUser({ (err : NSError?) in
                        completion(newUser: user.isNew, err: nil)
                    })
                    
                } else {
                    println("User logged in through Facebook!")
                    self.syncForNewUser({ (err : NSError?) in
                        completion(newUser: user.isNew, err: nil)
                    })

                }
            } else {
                println("Uh oh. The user cancelled the Facebook login.")
                completion(newUser: false, err: error)
            }
        })
    }
    
    func logout() {
        OAUser.logOut()
        PFFacebookUtils.unlinkUserInBackground(PFUser.currentUser())
        PFFacebookUtils.facebookLoginManager().logOut()
        
        PFInstallation.currentInstallation().removeObjectForKey("user")
        PFInstallation.currentInstallation().saveInBackground()
        
        PFQuery.clearAllCachedResults()
    }
    
    func syncForNewUser(completion : (err : NSError?) -> ()) {
        let request = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        request.startWithCompletionHandler({(connection, result, error) in
            if ((error) != nil)
            {
                // Process error
                println("Error: \(error)")
                completion(err: error)
            }
            
            println(result)
            
            let firstName   : String = result.valueForKey("first_name") as String
            let lastName    : String = result.valueForKey("last_name")  as String
            let userName    : String = result.valueForKey("name")       as String
            let userEmail   : String = result.valueForKey("email")      as String
            let gender      : String = result.valueForKey("gender")     as String
            let id          : String = result.valueForKey("id")         as String
            
            var friends = [String]()
            
            let friendRequest = FBSDKGraphRequest(graphPath: "me/friends", parameters: nil)
            friendRequest.startWithCompletionHandler({(friendConnection, friendResult, friendError) in
                if friendError != nil {
                    println(friendError)
                    completion(err: friendError)
                }
                
                for friend in friendResult["data"] as [AnyObject] {
                    let friendID = friend.objectForKey("id") as String?
                    if let f = friendID {
                        friends.append(f)
                    }
                }
                
                
                OAUser.currentUser().firstName = firstName
                OAUser.currentUser().lastName = lastName
                OAUser.currentUser().name = userName
                OAUser.currentUser().email = userEmail
                OAUser.currentUser().gender = gender
                OAUser.currentUser().facebookID = id
                OAUser.currentUser().oddsTitle = "New To The Odds"
                
                OAUser.currentUser().privateData = OAUserPrivateData()
                OAUser.currentUser().privateData.userID = OAUser.currentUser().objectId
                OAUser.currentUser().privateData.deviceID = UIDevice.currentDevice().identifierForVendor.UUIDString
                OAUser.currentUser().privateData.facebookFriends = friends
                
                OAUser.currentUser().saveInBackgroundWithBlock {
                    (success: Bool, error: NSError!) -> Void in
                    if (success) {
                        print("saved user data!")
                        completion(err: nil)
                    } else {
                        completion(err: error)
                    }
                }
            })
        })
    }
}

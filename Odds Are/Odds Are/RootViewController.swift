//
//  RootViewController.swift
//  Odds Are
//
//  Created by Jack Arendt on 3/21/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    private var login_shown = false
    private var loginVC : LoginViewController?
    private var newsFeedVC : NewsFeedViewController?
    private var oddsVC : OddsViewController?
    private var profileVC : ProfileViewController?
    private var settingsVC : SettingsTableViewController?
    private var newTabBarController = UITabBarController()
    private let utility = OAUtility()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = utility.sunriseGradient(view.bounds.size.height, width: view.bounds.size.width, rotated: true)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogout", name: utility.userDidLogOutNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if FBSDKAccessToken.currentAccessToken() != nil { //temporary before login and sso works
            presentMainInterface()
        }
        else {
            loginVC = LoginViewController()
            loginVC?.modalTransitionStyle = .CoverVertical
            if let lvc = loginVC {
                println(self.view.window?.rootViewController)
                presentViewController(lvc, animated: true, completion: nil)
                login_shown = true
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func presentMainInterface() {
        newsFeedVC  = NewsFeedViewController()
        oddsVC      = OddsViewController()
        profileVC   = ProfileViewController()
        settingsVC  = SettingsTableViewController(style: .Grouped)
        
        if newsFeedVC != nil && oddsVC != nil && profileVC != nil  && settingsVC != nil {
            let newsNC      = UINavigationController(rootViewController: newsFeedVC!)
            let oddsNC      = UINavigationController(rootViewController: oddsVC!)
            let profileNC   = UINavigationController(rootViewController: profileVC!)
            let settingsNC  = UINavigationController(rootViewController: settingsVC!)
            
            newsNC.navigationBar.translucent = false
            oddsNC.navigationBar.translucent = false
            profileNC.navigationBar.translucent = false
            settingsNC.navigationBar.translucent = false
            
            newsNC.navigationBar.tintColor = utility.sunriseRed
            oddsNC.navigationBar.tintColor = utility.sunriseRed
            profileNC.navigationBar.tintColor = utility.sunriseRed
            settingsNC.navigationBar.tintColor = utility.sunriseRed
            
            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName : UIFont(name: utility.lightFont, size: 21)!]
            UINavigationBar.appearance().barTintColor = utility.lightGrey
            
            newsNC.tabBarItem = UITabBarItem(title: "News Feed", image: UIImage(named: "newsfeed_tab"), selectedImage: nil)
            oddsNC.tabBarItem = UITabBarItem(title: "Odds", image: UIImage(named: "logo_tab"), selectedImage: nil)
            profileNC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile_tab"), selectedImage: nil)
            settingsNC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings_tab"), selectedImage: nil)
            
            newTabBarController.setViewControllers([newsNC, oddsNC, profileNC, settingsNC], animated: false)
            
            newTabBarController.tabBar.tintColor = utility.sunriseRed
            newTabBarController.tabBar.translucent = false;
            self.navigationController?.setViewControllers([self, newTabBarController], animated: false)
        }
        else {
            print("allocation failed")
        }
    }
    
    func userDidLogout() {
        self.navigationController?.popToRootViewControllerAnimated(false)
        if FBSDKAccessToken.currentAccessToken() != nil { //temporary before login and sso works
            presentMainInterface()
        }
        else {
            loginVC = LoginViewController()
            loginVC?.modalTransitionStyle = .CoverVertical
            if let lvc = loginVC {
                println(self.view.window?.rootViewController)
                presentViewController(lvc, animated: true, completion: nil)
                login_shown = true
            }
        }
    }
    
}

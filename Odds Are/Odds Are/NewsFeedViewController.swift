//
//  NewsFeedViewController.swift
//  Odds Are
//
//  Created by Jack Arendt on 3/21/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    private var height : CGFloat = 0
    private var width  : CGFloat = 0
    private let utility  = OAUtility()
    private var collectionView : UICollectionView!
    private var refreshControl : UIRefreshControl!
    private var searchBar : UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "News Feed"
        height = view.bounds.size.height
        width = view.bounds.size.width
        let gradient = utility.sunriseGradient(height, width: width, rotated: true)
        view = gradient

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Vertical
        let collectionViewHeight = height - 20
        collectionView = UICollectionView(frame: CGRectMake(0, 0, width, height), collectionViewLayout: layout)
        collectionView.registerClass(NewsFeedCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clearColor()
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.whiteColor()
        refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        collectionView.addSubview(refreshControl)
        view.addSubview(collectionView)
        
        searchBar = UISearchBar()
        searchBar.bounds =  CGRectMake(0, 0, width - 150, 44)
        searchBar.placeholder = "Search"
        searchBar.barTintColor = UIColor.clearColor()
        searchBar.alpha = 0
        navigationItem.titleView = nil
        addNavBarButtons()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "statusBarChanged", name: utility.statusBarChangeNotification, object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func statusBarChanged() {
        height = view.bounds.size.height
        width = view.bounds.size.width
        collectionView.frame = CGRectMake(0, 0, width, height)
    }
    
    // MARK: Nav bar methods
    
    func addOdds() {
        let newOdds = NewOddsViewController()
        let nc = UINavigationController(rootViewController: newOdds)
        presentViewController(nc, animated: true, completion: nil)
    }
    
    func search() {
        navigationItem.rightBarButtonItems = nil
        navigationItem.titleView = self.searchBar
        searchBar.becomeFirstResponder()
        UIView.animateKeyframesWithDuration(0.3, delay: 0, options: .CalculationModeCubicPaced, animations: {
            self.searchBar.alpha = 1
            }, { finished in
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancel")
        })
    }
    
    func cancel() {
        searchBar.resignFirstResponder()
        UIView.animateKeyframesWithDuration(0.3, delay: 0, options: .CalculationModeCubicPaced, animations: {
            self.searchBar.alpha = 0
            }, { finished in
                self.addNavBarButtons()
                self.navigationItem.titleView = nil
                
        })
        
    }
    
    func addNavBarButtons() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addOdds")
        let searchButton = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "search")
        navigationItem.rightBarButtonItems = [addButton, searchButton]
    }

    
    func refresh() {
        refreshControl.endRefreshing()
    }
    
    
    // MARK: CollectionView delegate methods
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as NewsFeedCollectionViewCell
        
        cell.challengerImage = UIImage(named: "profile")
        cell.challengerName = "Jack A"
        cell.challengeeName = "Leah V"
        cell.challengeeImage = UIImage(named: "profile")
        cell.chosenOdds = 50
        cell.challengerOdds = 42
        cell.challengeeOdds = 42
        cell.challenge = "Go to Starbucks"
        cell.time = "9:52AM"
        cell.date = "March 23rd, 2015"
        cell.OddsStage = OAUtility.OddsStage.PhotoPresent
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(width - 20, width * 0.75)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(width, 10)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSizeMake(width, 70)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

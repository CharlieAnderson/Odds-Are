//
//  OddsViewController.swift
//  Odds Are
//
//  Created by Jack Arendt on 3/21/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

import UIKit

class OddsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SegmentedTabViewDelegate, UISearchBarDelegate {

    private var height : CGFloat = 0
    private var width  : CGFloat = 0
    private let utility  = OAUtility()
    
    private var selectedIndex = 0
    private var segmentView : SegmentedTabView!
    private var tableView : UITableView!
    private var refreshControl : UIRefreshControl!
    private var searchBar : UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        height = view.bounds.size.height
        width = view.bounds.size.width
        let gradient = utility.sunriseGradient(height, width: width, rotated: true)
        view = gradient
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .Plain, target: nil, action: nil)

        let tableViewHeight = height - UIApplication.sharedApplication().statusBarFrame.size.height
        tableView = UITableView(frame: CGRectMake(0, 0, width, tableViewHeight - 44 - 49), style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(OddsTableViewCell.self, forCellReuseIdentifier: "odds")
        tableView.backgroundColor = UIColor.clearColor()
        tableView.tableFooterView = utility.tableFooterView("20 Current Odds", width: width, height: height)
        view.addSubview(tableView)
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.whiteColor()
        refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: "changeSegmentedTabViewIndex:")
        leftSwipe.direction = .Left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: "changeSegmentedTabViewIndex:")
        rightSwipe.direction = .Right
        view.addGestureRecognizer(rightSwipe)
        tableView.reloadData()

        searchBar = UISearchBar()
        searchBar.bounds =  CGRectMake(0, 0, width - 150, 44)
        searchBar.placeholder = "Search"
        searchBar.barTintColor = UIColor.clearColor()
        searchBar.alpha = 0
        searchBar.delegate = self
        navigationItem.titleView = nil
        navigationItem.title = "Odds"
        addNavBarButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: nav bar methods
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
    
    //MARK: segmented tab methods
    func changeSegmentedTabViewIndex(sender : UISwipeGestureRecognizer!) {
        segmentView.moveSliderSwiped(sender)
        selectedIndex = segmentView.selectedIndex
    }
    
    func segmentedTabViewFinishedAnimating() {
        tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: .Bottom, animated: true)
        if selectedIndex == 0 {
            tableView.tableFooterView = utility.tableFooterView("20 Current Odds", width: width, height: height)
        }
        else {
            tableView.tableFooterView = utility.tableFooterView("20 Past Odds", width: width, height: height)
        }
        tableView.reloadData()
    }
    
    func segmentedTabViewDidSelect(selected: Int) {
        selectedIndex = selected
    }

    
    // MARK: Tableview delegate methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : OddsTableViewCell = tableView.dequeueReusableCellWithIdentifier("odds", forIndexPath: indexPath) as OddsTableViewCell
        cell.name = "Leah V"
        cell.profileImage = UIImage(named: "profile")
        cell.challenge = "Go to Starbucks"
        cell.odds = 50
        cell.yourOdds = 23
        cell.lastUpdated = "9:52AM"
        cell.OddsStage = OAUtility.OddsStage.VideoPresent
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        segmentView = SegmentedTabView(frame: CGRectMake(0, 0, width, 45))
        segmentView.titles = ["Current Odds", "Past Odds"]
        segmentView.delegate = self
        segmentView.setSliderIndex(selectedIndex, animated: false)
        return segmentView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        navigationController?.pushViewController(ChallengeViewController(), animated: true)
    }
    
    func refresh() {
        print("refreshing")
        refreshControl.endRefreshing()
    }
}

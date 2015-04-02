//
//  ProfileViewController.swift
//  Odds Are
//
//  Created by Jack Arendt on 3/21/15.
//  Copyright (c) 2015 John Arendt. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SegmentedTabViewDelegate, UISearchBarDelegate{

    private var height : CGFloat = 0
    private var width  : CGFloat = 0
    private let utility  = OAUtility()
    private var tableView : UITableView!
    private var segmentView : SegmentedTabView!
    private var selectedIndex = 0
    
    private let statisticsCellIdentifier = "statistics"
    private let contactCellIdentifier = "contact"
    private let statisticsIndex = 0
    private let contactIndex = 1
    private var searchBar : UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile"
        height = view.bounds.size.height
        width = view.bounds.size.width
        let gradient = utility.sunriseGradient(height, width: width, rotated: true)
        view = gradient

        addNavBarButtons()
        searchBar = UISearchBar(frame: CGRectMake(0, 0, width - 150, 44))
        searchBar.placeholder = "Search"
        searchBar.barTintColor = UIColor.clearColor()
        searchBar.alpha = 0
        searchBar.delegate = self
        
        
        let tableViewHeight = height - UIApplication.sharedApplication().statusBarFrame.size.height
        tableView = UITableView(frame: CGRectMake(0, 0, width, tableViewHeight - 44 - 49), style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(ContactTableViewCell.self, forCellReuseIdentifier: contactCellIdentifier)
        tableView.registerClass(StatisticsTableViewCell.self, forCellReuseIdentifier: statisticsCellIdentifier)
        tableView.backgroundColor = UIColor.clearColor()
        tableView.tableHeaderView = profileHeaderView()
        tableView.tableFooterView = utility.tableFooterView(nil, width: width, height: height)
        view.addSubview(tableView)
        
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: "changeSegmentedTabViewIndex:")
        leftSwipe.direction = .Left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: "changeSegmentedTabViewIndex:")
        rightSwipe.direction = .Right
        view.addGestureRecognizer(rightSwipe)
        
        tableView.reloadData()
        addNavBarButtons()
    }
    
    func profileHeaderView() -> ProfileHeaderView {
        let headerView = ProfileHeaderView(frame: CGRectMake(0, 0, width, 200))
        headerView.profileImage = UIImage(named: "profile")
        headerView.title = "Odds Master"
        headerView.name = "Jack Arendt"
        return headerView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Nav Bar Selectors
    
    func addNavBarButtons() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addOdds")
        let searchButton = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "search")
        navigationItem.rightBarButtonItems = [addButton, searchButton]
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
                self.navigationItem.titleView = nil
                self.addNavBarButtons()
                
        })
    }
    
    func addOdds() {
        let newOdds = NewOddsViewController()
        let nc = UINavigationController(rootViewController: newOdds)
        presentViewController(nc, animated: true, completion: nil)
    }

    
    // MARK: Header methods 
    func changeSegmentedTabViewIndex(sender : UISwipeGestureRecognizer!) {
        segmentView.moveSliderSwiped(sender)
        selectedIndex = segmentView.selectedIndex
    }
    
    func segmentedTabViewFinishedAnimating() {
        tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: .Bottom, animated: true)
        if selectedIndex == 0 {
            tableView.tableFooterView = utility.tableFooterView(nil, width: width, height: height)
        }
        else {
            tableView.tableFooterView = utility.tableFooterView("20 Contacts", width: width, height: height)
        }
        tableView.reloadData()
    }
    
    func segmentedTabViewDidSelect(selected: Int) {
        selectedIndex = selected
    }
    
    // MARK: TableView delegate methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if selectedIndex == contactIndex {
            let cell: ContactTableViewCell = tableView.dequeueReusableCellWithIdentifier(contactCellIdentifier, forIndexPath: indexPath) as ContactTableViewCell
            cell.profileImage = UIImage(named: "profile")
            cell.name = "Leah Vaughn"
            cell.lastUsed = "Last Active 2 Hours Ago"
            return cell
        }
        else if selectedIndex == statisticsIndex {
            let cell : StatisticsTableViewCell = tableView.dequeueReusableCellWithIdentifier(statisticsCellIdentifier, forIndexPath: indexPath) as StatisticsTableViewCell
            cell.statName = "Average Chosen Odds"
            cell.statValue = 40
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        segmentView = SegmentedTabView(frame: CGRectMake(0, 0, width, 45))
        segmentView.titles = ["Statistics", "Contacts"]
        segmentView.delegate = self
        segmentView.setSliderIndex(selectedIndex, animated: false)
        return segmentView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: Search Bar Delegate Methods
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        cancel()
    }
}

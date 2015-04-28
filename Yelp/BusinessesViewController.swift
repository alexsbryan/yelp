//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FiltersViewControllerDelegate, UISearchBarDelegate {

    var businesses: [Business]!
    
    @IBOutlet weak var tableView: UITableView!
    var searchBar = UISearchBar()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 120
        
        navigationItem.titleView = searchBar
        if let nc = navigationController {
            nc.navigationBar.barTintColor = UIColor(red:0.78, green:0.09, blue:0.07, alpha:0.94)
            nc.navigationBar.tintColor = UIColor.whiteColor()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell") as! BusinessCell
        cell.setBusiness(self.businesses[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let businesses = self.businesses {
            return businesses.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let contentView: UIView = tableView.dataSource!.tableView(tableView, cellForRowAtIndexPath: indexPath)
        contentView.updateConstraintsIfNeeded()
        contentView.layoutIfNeeded()
        return contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
    }

 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationViewController = segue.destinationViewController as! UINavigationController
        
        let filtersViewController = navigationViewController.topViewController as! FiltersViewController
        
        filtersViewController.delegate = self
    }
    
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String : AnyObject]) {
        var categories = filters["categories"] as? [String]
        var queryTerm: String
        
        if let searchTerm = searchBar.text {
            queryTerm = searchTerm
        } else {
            queryTerm = "Restaurants"
        }

        Business.searchWithTerm(queryTerm, sort: YelpSortMode(rawValue: filters["sort"] as! Int), categories: categories, deals: filters["deals"] as? Bool) {
            (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        Business.searchWithTerm(searchBar.text) {
            (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
            searchBar.endEditing(true)
        }
    }


}

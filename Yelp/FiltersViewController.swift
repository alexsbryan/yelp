//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Alex & Chelsea Bryan on 4/26/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol FiltersViewControllerDelegate {
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String:AnyObject])
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate, RadiusCellDelegate, SortCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var categories: [[String:String]]!
    var switchStates = [Int:Bool]()
    var deals = false
    var matchType = 0
    weak var delegate: FiltersViewControllerDelegate?
    
    let filterSections: [String] = ["Categories", "Sort", "Radius", "Deals"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categories = yelpCategories()
        tableView.dataSource = self
        tableView.delegate = self
        if let nc = navigationController {
            nc.navigationBar.barTintColor = UIColor(red:0.78, green:0.09, blue:0.07, alpha:0.94)
            nc.navigationBar.tintColor = UIColor.whiteColor()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onSearchButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
        var filters = [String:AnyObject]()
        
        var selectedCategories = [String]()
        
        for (row,isSelected) in switchStates {
            if isSelected {
                selectedCategories.append(categories[row]["code"]!)
            }
        }
        
        if selectedCategories.count > 0 {
            filters["categories"] = selectedCategories
        }
        println(deals)
        println("Asdfsdfsadfasdfs")
        filters["deals"] = deals
        filters["sort"] = matchType
        
        delegate?.filtersViewController(self, didUpdateFilters: filters)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return categories.count
        default:
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! SwitchCell
            
            cell.switchLabel.text = categories[indexPath.row]["name"]
            
            cell.delegate = self
            
            cell.onSwitch.on = switchStates[indexPath.row] ?? false
            
            return cell
        case 1:
           //Sort
            let cell = tableView.dequeueReusableCellWithIdentifier("SortCell", forIndexPath: indexPath) as! SortCell
            cell.delegate = self
            //save on off state
            return cell
        case 2:
            //Radius
            let cell = tableView.dequeueReusableCellWithIdentifier("RadiusCell", forIndexPath: indexPath) as! RadiusCell
            cell.delegate = self
            //save the on off state
            return cell
        default:
            //Deals
            let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as! SwitchCell
            cell.switchLabel.text = "Deals Only"
            //cell.mySwitch.on = ownFilterConfiguration.dealsOnly
            cell.delegate = self
            return cell
        }
        
    }
    
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPathForCell(switchCell)!
        
        switch indexPath.section {
        case 0:
            switchStates[indexPath.row] = value
        default:
            deals = value
        }
    }
    
    func sortCell(sortCell: SortCell, sortChanged newSortValue: Int) {
        println(newSortValue)
        matchType = newSortValue
    }
    
    func radiusCell(radiusCell: RadiusCell, didChangeValue value: Bool) {
        /// need to update the options
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return filterSections.count
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return filterSections[section]
    }
    
    //Categories
    func yelpCategories() -> [[String:String]] {
        return [["name" : "Afghan", "code": "afghani"],
            ["name" : "African", "code": "african"],
            ["name" : "American, New", "code": "newamerican"],
            ["name" : "American, Traditional", "code": "tradamerican"],
            ["name" : "Israeli", "code": "israeli"],
            ["name" : "Italian", "code": "italian"],
            ["name" : "Japanese", "code": "japanese"],
            ["name" : "Jewish", "code": "jewish"],
            ["name" : "Milk Bars", "code": "milkbars"],
            ["name" : "Modern Australian", "code": "modern_australian"],
            ["name" : "Modern European", "code": "modern_european"],
            ["name" : "Mongolian", "code": "mongolian"],
            ["name" : "Moroccan", "code": "moroccan"],
            ["name" : "New Zealand", "code": "newzealand"],
            ["name" : "Soul Food", "code": "soulfood"],
            ["name" : "Soup", "code": "soup"],
            ["name" : "Southern", "code": "southern"],
            ["name" : "Spanish", "code": "spanish"],
            ["name" : "Steakhouses", "code": "steak"],
            ["name" : "Sushi Bars", "code": "sushi"],
            ["name" : "Swabian", "code": "swabian"],
            ["name" : "Swedish", "code": "swedish"],
            ["name" : "Swiss Food", "code": "swissfood"]]
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

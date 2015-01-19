//
//  TableViewController.swift
//  HUDSmart
//
//  Created by Harry Xue on 11/29/14.
//  Copyright (c) 2014 Chris Chen, Eshaan Patheria, Harry Xue. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIControllerProtocol {
    
    // connect to APIController
    var api = APIController?()
    
    // connect to table in storyboard
    @IBOutlet var appsTableView : UITableView?
    
    // connect to buttons in storyboard
    @IBOutlet weak var breakfastButton: UIButton!
    @IBOutlet weak var lunchButton: UIButton!
    @IBOutlet weak var dinnerButton: UIButton!
    // storyboard prototype for table cell
    let kCellIdentifier: String = "TableCell"
    
    
    // stores table data
    var menuitems = [MenuItem]()
    
    // stores meal type
    var mealType = "LUNCH"
    
    // tell view controller which item is being looked at
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var factPageViewController: FactPageViewController = segue.destinationViewController as FactPageViewController
        var itemIndex = appsTableView!.indexPathForSelectedRow()!.row
        var selectedItem = self.menuitems[itemIndex]
        factPageViewController.item = selectedItem
    }
    
    // event handling for pressed buttons
    // set meal type and and reload view
    @IBAction func breakfastPressed(sender: AnyObject) {
        mealType = "BREAKFAST"
        self.viewDidLoad()
    }
    
    @IBAction func lunchPressed(sender: AnyObject) {
        mealType = "LUNCH"
        self.viewDidLoad()
    }

    @IBAction func dinnerPressed(sender: AnyObject) {
        mealType = "DINNER"
        self.viewDidLoad()
    }
    
    // sets table size
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        return menuitems.count
    }
    
    // fills cells
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as UITableViewCell
        //let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default")

        // get and display name of item
        let item = self.menuitems[indexPath.row]
        cell.textLabel!.text = item.name
        
        // get the formatted portion string for display in the subtitle
        let formattedPortion = "\(item.portion) \(item.unit)"
        cell.detailTextLabel?.text = formattedPortion
        
        return cell
    }
    
    // property to store parsed data from the server
    var items = NSArray()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // construct APIController object, setting delegate for api controller to itself
        api = APIController(delegate: self)
        
        // show networkActivityIndicator
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        // fetch data
        api!.fetchJSON(mealType)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // callback method
    func didReceiveAPIResults(results : NSArray) {
        dispatch_async(dispatch_get_main_queue(), {
            self.menuitems = MenuItem.itemsWithJSON(results)
            self.appsTableView!.reloadData()
            
            // turn off networkActivityIndicator
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
 }


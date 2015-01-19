//
//  ViewController.swift
//  macr05
//
//  Created by Harry Xue on 11/29/14.
//  Copyright (c) 2014 Chris Chen, Eshaan Patheria, Harry Xue. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // connect to table in Storyboard
    @IBOutlet var appsTableView : UITableView?
    
    // stores table data
    var tableData = []
    
    // required functions for view controller
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
            let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        
            let rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        
            cell.textLabel.text = rowData["name"] as? String
        
            // Get the portion size for display in the subtitle
            let portion: NSString = rowData["portion"] as NSString
            let units: NSString = rowData["unit"] as NSString
        
            cell.detailTextLabel?.text = "\(portion) \(units)"
        
            return cell
    }
    
    // property to store parsed data from the server
    var items = NSArray()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // fetch data
        fetchJSON()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchJSON()
    {
        let url = NSURL(string: "http://api.cs50.net/food/3/menus?key=87f644ba49c619c235de91a7cb34c324&meal=LUNCH&sdt=2014-11-10&edt=2014-11-10&output=json")
        if url == nil
        {
            println("Unable to parse string into NSURL")
            return
        }
        
        let session = NSURLSession.sharedSession()
        
        // one way to fetch data from the Internet is to use a Task
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            if error != nil
            {
                // An error is present, print it and abort
                println("Web request error: \(error.localizedDescription)")
                return
            }
            
            // a variable to store parse errors
            var parseError: NSError?
            
            // parse the JSON data (from: http://stackoverflow.com/questions/26840203/parsing-json-array-in-swift )
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &parseError) as NSArray?
            
            // check for errors from parsing
            if parseError != nil
            {
                // print errors to the console
                println("JSON parse error: \(parseError!.localizedDescription)")
                return
            }
            
            // success!
            println("Success!")
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableData = jsonResult!
                self.appsTableView!.reloadData()
            })
        })
        
        task.resume()
    }


}


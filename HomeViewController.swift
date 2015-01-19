//
//  HomeViewController.swift
//  HUDSmart
//
//  Created by Harry Xue on 12/4/14.
//  Copyright (c) 2014 Chris Chen, Eshaan Patheria, Harry Xue. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    // label connections
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var carbsLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    @IBOutlet weak var proteinPercentLabel: UILabel!
    @IBOutlet weak var carbsPercentLabel: UILabel!
    @IBOutlet weak var fatPercentLabel: UILabel!
    
    // use managedObjectContext
    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext {
            return managedObjectContext
        }
        else
        {
            return nil
        }
        }()
    
    // calculates total calories for all meals and returns amount as String
    func fetchCalories() -> String {
        
        var calories = 0.00
        
        // access NSUserDefaults
        let fetchRequest = NSFetchRequest(entityName: "Item")
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Item]{
            for result in fetchResults
            {
                // add  each item's calories to total calorie count
                var resultCalories = (result.calories as NSString).doubleValue
                var resultQuantity = (result.quantity as NSString).doubleValue
                var addCalories = resultCalories * resultQuantity
                calories += addCalories
            }
        }
        return String(format:"%.2f", calories)
    }
    
    // calculates total protein for all meals and returns amount as String
    func fetchProtein() -> String {
        
        var protein = 0.00
        
        let fetchRequest = NSFetchRequest(entityName: "Item")
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Item] {
            for result in fetchResults
            {
                var resultProtein = (result.protein as NSString).doubleValue
                var resultQuantity = (result.quantity as NSString).doubleValue
                var addProtein = resultProtein * resultQuantity
                protein += addProtein
            }
        }
        return String(format:"%.2f", protein)
    }
    
    // calculates total carbs for all meals and returns amount as String
    func fetchCarbs() -> String {
        
        var carbs = 0.00
        
        let fetchRequest = NSFetchRequest(entityName: "Item")
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Item] {
            for result in fetchResults
            {
                var resultCarbs = (result.totalCarbs as NSString).doubleValue
                var resultQuantity = (result.quantity as NSString).doubleValue
                var addCarbs = resultCarbs * resultQuantity
                carbs += addCarbs
            }
        }
        return String(format:"%.2f", carbs)
    }
    
    // calculates total fat for all meals and returns amount as String
    func fetchFat() -> String {
        
        var fat = 0.00
        
        let fetchRequest = NSFetchRequest(entityName: "Item")
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Item] {
            for result in fetchResults
            {
                var resultFat = (result.totalFat as NSString).doubleValue
                var resultQuantity = (result.quantity as NSString).doubleValue
                var addFat = resultFat * resultQuantity
                fat += addFat
            }
        }
        return String(format:"%.2f", fat)
    }
    
    func calcPercentProtein() -> String {
        // Get stored data
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var proteinSet: Int = defaults.integerForKey("protein")
        
        // Check for division by 0
        if proteinSet == 0
        {
            return "N/A"
        }
        
        // Calculate percent as float
        var proteinPercent = ((fetchProtein() as NSString).doubleValue / Double(proteinSet)) * 100.00
        
        // Convert float value to string
        var proteinPercentString = NSString(format: "%.2f", proteinPercent)
        
        return proteinPercentString
    }
    
    func calcPercentCarbs() -> String {
        // Get stored data
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var carbsSet: Int = defaults.integerForKey("carbs")
        
        // Check for division by 0
        if carbsSet == 0
        {
            return "N/A"
        }
        
        // Calculate percent as float
        var carbsPercent = ((fetchCarbs() as NSString).doubleValue / Double(carbsSet)) * 100.00
        
        // Convert float value to string
        var carbsPercentString = NSString(format: "%.2f", carbsPercent)
        
        return carbsPercentString
    }
    
    func calcPercentFat() -> String {
        // Get stored data
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var fatSet: Int = defaults.integerForKey("fat")
        
        // Check for division by 0
        if fatSet == 0
        {
            return "N/A"
        }
        
        // Calculate percent as float
        var fatPercent = ((fetchFat() as NSString).doubleValue / Double(fatSet)) * 100.00
        
        // Convert float value to string
        var fatPercentString = NSString(format: "%.2f", fatPercent)
        
        return fatPercentString
    }
    
    // reset button event handling
    @IBAction func resetButton(sender: AnyObject) {
        // if pressed, clear Core Data database
        let fetchRequest = NSFetchRequest(entityName: "Item")
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Item] {
            for result in fetchResults
            {
                // delete all entries
                managedObjectContext?.deleteObject(result)
                managedObjectContext?.save(nil)
            }
        }
        
        // reload view
        viewDidAppear(true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // generate labels
        caloriesLabel.text = fetchCalories()
        carbsLabel.text = fetchCarbs()
        proteinLabel.text = fetchProtein()
        fatLabel.text = fetchFat()
        proteinPercentLabel.text = calcPercentProtein()
        carbsPercentLabel.text = calcPercentCarbs()
        fatPercentLabel.text = calcPercentFat()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // generate labels
        caloriesLabel.text = fetchCalories()
        carbsLabel.text = fetchCarbs()
        proteinLabel.text = fetchProtein()
        fatLabel.text = fetchFat()
        proteinPercentLabel.text = calcPercentProtein()
        carbsPercentLabel.text = calcPercentCarbs()
        fatPercentLabel.text = calcPercentFat()
    }
    
}
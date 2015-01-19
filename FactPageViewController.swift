//
//  FactPageViewController.swift
//  HUDSmart
//
//  Created by Harry Xue on 11/30/14.
//  Copyright (c) 2014 Chris Chen, Eshaan Patheria, Harry Xue. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class FactPageViewController: UIViewController, APIControllerProtocol {
    
    // set delegate
    lazy var api : APIController = APIController(delegate: self)
    
    // outlets
    @IBOutlet weak var factsTableView: UITableView!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    // item
    var item: MenuItem?
    
    // quantity of item
    struct quantity {
        static var value = 0;
        
    }
    
    // create cell identifier
    let factCellIdentifier: String = "FactCell"
    
    // array of facts
    var facts = [NutritionFact]()
    
    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext
        {
            return managedObjectContext
        }
        else
        {
            return nil
        }
        }()
    
    // updates item quantity if it exists, else saves item
    func updateItem() {
        var itemExists: Bool = false
        let fetchRequest = NSFetchRequest(entityName: "Item")
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Item] {
            // check for name match
            for result in fetchResults
            {
                // if match found, update quantity
                if result.name == self.item?.name
                {
                    itemExists = true
                    result.quantity = String(quantity.value)
                    // save Core Data
                    save()
                }
            }
            if itemExists == false
            {
                saveItem()
                // save Core Data
                save()
            }
        }
    }
    
    // add item as core data object
    func saveItem() {
        
        let item = NSEntityDescription.insertNewObjectForEntityForName("Item", inManagedObjectContext: self.managedObjectContext!) as Item
        
        // set all the attributes
        item.name = self.item!.name
        item.id = self.item!.recipe
        item.quantity = String(quantity.value)
        item.calcium = self.facts[0].amount
        item.calories = self.facts[1].amount
        item.caloriesFromFat = self.facts[2].amount
        item.cholesterol = self.facts[3].amount
        item.dietaryFiber = self.facts[4].amount
        item.iron = self.facts[5].amount
        item.protein = self.facts[6].amount
        item.saturatedFat = self.facts[7].amount
        item.sodium = self.facts[8].amount
        item.sugars = self.facts[9].amount
        item.totalCarbs = self.facts[10].amount
        item.totalFat = self.facts[11].amount
        item.transFat = self.facts[12].amount
        item.vitaminA = self.facts[13].amount
        item.vitaminC = self.facts[14].amount
    }
    
    // saves Core Data
    func save() {
        var error : NSError?
        if (managedObjectContext!.save(&error) )
        {
            println(error?.localizedDescription)
        }
    }
    
    // handles stepper events
    @IBAction func stepperValueChanged(sender: UIStepper) {
        // test for edge case of Chef's special, which was causing app to crash due to lack of nutrition facts (misspelling intentional as that is how it is spelled in JSON request)
        if facts.count != 0
        {
            // sets quantity as sender value
            quantity.value = Int(sender.value)
            
            // displays sender value
            valueLabel.text = Int(sender.value).description
            updateItem()
        }
    }
    
    // required for Core Data
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemLabel.text = self.item?.name
        
        // Load in facts
        if self.item != nil
        {
            // show networkActivityIndicator
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            
            api.lookupFacts(self.item!.recipe)
        }
        stepper.value = Double(quantity.value)
        
        // set properties of stepper
        stepper.wraps = true
        stepper.autorepeat = true
        stepper.maximumValue = 10
        
        // check to see if item record exists
        let fetchRequest = NSFetchRequest(entityName: "Item")
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [Item] {
            // check for name match
            for result in fetchResults
            {
                // if match found, update quantity and label
                if result.name == self.item?.name
                {
                    // set quantity to value from Core Data
                    quantity.value = result.quantity.toInt()!
                    stepper.value = Double(quantity.value)
                    valueLabel.text = String(quantity.value)
                    return
                }
            }
            stepper.value = 0.0
        }
        
    }
    
    // set number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = factsTableView.dequeueReusableCellWithIdentifier(factCellIdentifier) as UITableViewCell
        //let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Default")
        // get and display name of fact
        let fact = self.facts[indexPath.row]
        cell.textLabel!.text = fact.fact
        
        // get the amount for display in the right detail and display correct units
        if fact.fact == "Sodium" || fact.fact == "Cholesterol" || fact.fact == "Vitamin A" || fact.fact == "Vitamin C" || fact.fact == "Calcium" || fact.fact == "Iron"
        {
            cell.detailTextLabel?.text = fact.amount + " mg"
        }
        else if fact.fact == "Calories" || fact.fact == "Calories from Fat"
        {
            cell.detailTextLabel?.text = fact.amount
        }
        else
        {
            cell.detailTextLabel?.text = fact.amount + " g"
        }
        
        return cell
    }
    
    func didReceiveAPIResults(results: NSArray) {
        dispatch_async(dispatch_get_main_queue(), {
            self.facts = NutritionFact.factsWithJSON(results)
            self.factsTableView.reloadData()
            
            // turn off networkActivityIndicator
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }
}
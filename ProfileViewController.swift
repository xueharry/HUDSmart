//
//  ProfileViewController.swift
//  HUDSmart
//
//  Created by Eshaan Patheria on 12/4/14.
//  Copyright (c) 2014 Chris Chen, Eshaan Patheria, Harry Xue. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    // connections to text fields
    @IBOutlet weak var carbsTextField: UITextField!
    @IBOutlet weak var fatTextField: UITextField!
    @IBOutlet weak var proteinTextField: UITextField!
    
    override func viewDidLoad() {
        // Get the stored date before the view loads from NSUserDefaults
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        var carbs: Int = defaults.integerForKey("carbs")
        var fat: Int = defaults.integerForKey("fat")
        var protein: Int = defaults.integerForKey("protein")
        
        // Convert stored data to strings
        carbsTextField.text = String(carbs)
        fatTextField.text = String(fat)
        proteinTextField.text = String(protein)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonClick(sender: AnyObject) {
        // Hide the keyboard
        self.view.endEditing(true)
        
        // Create integers to store input info
        var carbsConversion:Int = 0
        var fatConversion:Int = 0
        var proteinConversion:Int = 0
        
        // Convert strings for input info
        var carbs:String = carbsTextField.text
        var fat:String = fatTextField.text
        var protein:String = proteinTextField.text
        
        // Check for empty strings
        if carbs == ""
        {
            carbs = "0"
        }
        
        if fat == ""
        {
            fat = "0"
        }
        
        if protein == ""
        {
            protein = "0"
        }
        
        // Convert strings to ints
        carbsConversion = carbs.toInt()!
        fatConversion = fat.toInt()!
        proteinConversion = protein.toInt()!
        
        // Store data
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setInteger(carbsConversion, forKey: "carbs")
        defaults.setInteger(fatConversion, forKey: "fat")
        defaults.setInteger(proteinConversion, forKey: "protein")
        
        defaults.synchronize()
    }
    @IBAction func resetButtonClick(sender: AnyObject) {
        // Access NSUser defaults
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        // reset values
        defaults.setInteger(0, forKey: "carbs")
        defaults.setInteger(0, forKey: "fat")
        defaults.setInteger(0, forKey: "protein")
        
        // reload page
        viewDidLoad()
    }
}
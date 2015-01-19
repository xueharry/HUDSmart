//
//  NutritionFact.swift
//  HUDSmart
//
//  Created by Harry Xue on 11/30/14.
//  Copyright (c) 2014 Chris Chen, Eshaan Patheria, Harry Xue. All rights reserved.
//

import Foundation

// create model for Nutrition Facts
class NutritionFact {
    
    // fields
    var fact: String
    var amount: String
    
    // initializer
    init(fact: String, amount: String) {
        self.fact = fact
        self.amount = amount
    }
    
    // create an array of nutrition facts
    class func factsWithJSON(allResults: NSArray) -> [NutritionFact] {
        
        // create an empty array of items to append to from this list
        var items = [NutritionFact]()
        
        // store the results in our table data array
        if allResults.count > 0
        {
            for result in allResults
            {
                var fact = result["fact"] as String
                var amount = result["amount"] as? String

                // check for nil values
                if amount == nil
                {
                    amount = "0.00"
                }
                
                
                // initialize and append to array
                var newNutritionFact = NutritionFact(fact: fact, amount: amount!)
                items.append(newNutritionFact)
            }
        }
        return items
    }
}

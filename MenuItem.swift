//
//  MenuItem.swift
//  HUDSmart
//
//  Created by Harry Xue on 11/30/14.
//  Copyright (c) 2014 Chris Chen, Eshaan Patheria, Harry Xue. All rights reserved.
//

import Foundation

class MenuItem {
    // fields for menu item
    var meal: String
    var category: String
    var recipe: String
    var name: String
    var portion: String
    var unit: String
    
    // initializer for MenuItem Object
    init(meal: String, category: String, recipe: String, name: String, portion: String, unit: String) {
        self.meal = meal
        self.category = category
        self.recipe = recipe
        self.name = name
        self.portion = portion
        self.unit = unit
        
    }
    
    class func itemsWithJSON(allResults: NSArray) -> [MenuItem] {
        
        // create an empty array of items to append to from this list
        var items = [MenuItem]()
        
        // store the results in our table data array
        if allResults.count > 0
        {
            for result in allResults
            {
                var meal = result["meal"] as String
                var category = result["category"] as String
                var recipe = result["recipe"] as String
                var name = result["name"] as String
                var portion = result["portion"] as String
                var unit = result["unit"] as String
                var newMenuItem = MenuItem(meal: meal, category: category, recipe: recipe, name: name, portion: portion, unit: unit)
                items.append(newMenuItem)
            }
            
        }
        return items

    }
}
    

//
//  Item.swift
//  HUDSmart
//
//  Created by Christopher Chen on 12/3/14.
//  Copyright (c) 2014 Chris Chen, Eshaan Patheria, Harry Xue. All rights reserved.
//

import Foundation
import CoreData

class Item: NSManagedObject {

    @NSManaged var calcium: String
    @NSManaged var calories: String
    @NSManaged var caloriesFromFat: String
    @NSManaged var cholesterol: String
    @NSManaged var dietaryFiber: String
    @NSManaged var id: String
    @NSManaged var iron: String
    @NSManaged var name: String
    @NSManaged var protein: String
    @NSManaged var quantity: NSNumber
    @NSManaged var saturatedFat: String
    @NSManaged var sodium: String
    @NSManaged var sugars: String
    @NSManaged var totalCarbs: String
    @NSManaged var totalFat: String
    @NSManaged var transFat: String
    @NSManaged var vitaminA: String
    @NSManaged var vitaminC: String

}

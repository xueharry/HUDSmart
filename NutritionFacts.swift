//
//  NutritionFacts.swift
//  HUDSmart
//
//  Created by Harry Xue on 11/30/14.
//  Copyright (c) 2014 Chris Chen, Eshaan Patheria, Harry Xue. All rights reserved.
//

import Foundation

// create model for Nutrition Facts
class NutritionFacts {
    
    // fields
    var calcium: String
    var calories: String
    var caloriesFromFat: String
    var cholesterol: String
    var dietaryFiber: String
    var iron: String
    var protein: String
    var saturatedFat: String
    var sodium: String
    var sugars: String
    var totalCarbs: String
    var totalFat: String
    var transFat: String
    var vitaminA: String
    var vitaminC: String
    
    // initializer for Nutrition Facts
    init(calcium: String, calories: String, caloriesFromFat: String, cholesterol: String, dietaryFiber: String, iron: String, protein: String, saturatedFat: String, sodium: String, sugars: String, totalCarbs: String, totalFat: String, transFat: String, vitaminA: String, vitaminC: String) {
        self.calcium = calcium
        self.calories = calories
        self.caloriesFromFat = caloriesFromFat
        self.cholesterol = cholesterol
        self.dietaryFiber = dietaryFiber
        self.iron = iron
        self.protein = protein
        self.saturatedFat = saturatedFat
        self.sodium = sodium
        self.sugars = sugars
        self.totalCarbs = totalCarbs
        self.totalFat = totalFat
        self.transFat = transFat
        self.vitaminA = vitaminA
        self.vitaminC = vitaminC
    }
    
    // turns JSON results into a NutritionFacts object
    class func factsWithJSON(allResults: NSArray) -> [NutritionFacts] {
        
        // initialize new Nutrition Facts object
        var calcium = allResults[0]["amount"] as? String
        var calories = allResults[1]["amount"] as? String
        var caloriesFromFat = allResults[2]["amount"] as? String
        var cholesterol = allResults[3]["amount"] as? String
        var dietaryFiber = allResults[4]["amount"] as? String
        var iron = allResults[5]["amount"] as? String
        var protein = allResults[6]["amount"] as? String
        var saturatedFat = allResults[7]["amount"] as? String
        var sodium = allResults[8]["amount"] as? String
        var sugars = allResults[9]["amount"] as? String
        var totalCarbs = allResults[10]["amount"] as? String
        var totalFat = allResults[11]["amount"] as? String
        var transFat = allResults[12]["amount"] as? String
        var vitaminA = allResults[13]["amount"] as? String
        var vitaminC = allResults[14]["amount"] as? String
        
        // check for nil values
        if calcium == nil
        {
            calcium = "N/A"
        }
        if calories == nil
        {
            calories = "N/A"
        }
        if caloriesFromFat == nil
        {
            caloriesFromFat = "N/A"
        }
        if cholesterol == nil
        {
            cholesterol = "N/A"
        }
        if dietaryFiber == nil
        {
            dietaryFiber = "N/A"
        }
        if iron == nil
        {
            iron = "N/A"
        }
        if protein == nil
        {
            protein = "N/A"
        }
        if saturatedFat == nil
        {
            saturatedFat = "N/A"
        }
        if sodium == nil
        {
            sodium = "N/A"
        }
        if sugars == nil
        {
            sugars = "N/A"
        }
        if totalCarbs == nil
        {
            totalCarbs = "N/A"
        }
        if totalFat == nil
        {
            totalFat = "N/A"
        }
        if transFat == nil
        {
            transFat = "N/A"
        }
        if vitaminA == nil
        {
            vitaminA = "N/A"
        }
        if vitaminC == nil
        {
            vitaminC = "N/A"
        }
        
        var newNutritionFacts = [NutritionFacts(calcium: calcium!, calories: calories!, caloriesFromFat: caloriesFromFat!, cholesterol: cholesterol!, dietaryFiber: dietaryFiber!, iron: iron!, protein: protein!, saturatedFat: saturatedFat!, sodium: sodium!, sugars: sugars!, totalCarbs: totalCarbs!, totalFat: totalFat!, transFat: transFat!, vitaminA: vitaminA!, vitaminC: vitaminC!)]
        
        return newNutritionFacts
    }
}

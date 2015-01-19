//
//  APIController.swift
//  HUDSmart
//
//  Created by Harry Xue on 11/29/14.
//  Copyright (c) 2014 Chris Chen, Eshaan Patheria, Harry Xue. All rights reserved.
//

import Foundation

// protocol for API Controller
protocol APIControllerProtocol {
    func didReceiveAPIResults(results: NSArray)
}

class APIController {
    
    // property that conforms to the APIControllerProtocol
    var delegate: APIControllerProtocol
    
    // constructor that accepts delegate as argument
    init(delegate: APIControllerProtocol) {
        self.delegate = delegate
    }
    
    // makes JSON request for a menu based on current date
    func fetchJSON(meal: String) {
        // declare variable for NSDateFormatter
        var dateFormatter = NSDateFormatter()
        // string representation of date
        dateFormatter.dateFormat = "yyyy-MM-dd"
        // variable for current date
        let date = NSDate()
        // get date as string from dateFormatter
        let dateAsString = dateFormatter.stringFromDate(date)
        // concatenate url
        let url = "http://api.cs50.net/food/3/menus?key=87f644ba49c619c235de91a7cb34c324&meal=" + meal + "&sdt=" + dateAsString + "&edt=" + dateAsString + "&output=json"
        get(url)
    }
    
    // makes JSON request for nutrition facts
    func lookupFacts(recipe: String) {
        get("http://api.cs50.net/food/3/facts?key=87f644ba49c619c235de91a7cb34c324&recipe=" + recipe + "&output=json")
    }
    
    // fetches JSON from CS50 Food API
    func get(path: String) {
        let url = NSURL(string: path)
        
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
            
            // pass responsibility of reloading UI to delegate
            self.delegate.didReceiveAPIResults(jsonResult!)
        })
        
        task.resume()
    }
    
    
}
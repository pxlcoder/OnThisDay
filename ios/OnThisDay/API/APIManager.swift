//
//  APIManager.swift
//  OnThisDay
//
//  Created by Aditya Keerthi on 2015-12-30.
//  Copyright © 2015 Aditya Keerthi. All rights reserved.
//

import Foundation

class APIManager {
    private var urlPath: String = "http://127.0.0.1:5000/onthisday"
    
    var month: Int?
    var day: Int?
    
    var dataDict: NSDictionary?
    
    var births:[Birth]
    var deaths:[Death]
    var events:[Event]
    
    init() {
        self.births = [Birth]()
        self.deaths = [Death]()
        self.events = [Event]()
    }
    
    convenience init(month: Int, day: Int) {
        self.init()
        
        self.month = month
        self.day = day
        
        urlPath += "/\(month)/\(day)"
    }
    
    func changeDate(month: Int, day: Int) {
        self.month = month
        self.day = day
    }
    
    func makeRequest() {
        do {
            let data = try NSData(contentsOfURL: NSURL(string:urlPath)!, options: NSDataReadingOptions())
            self.dataDict = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
            
            handleResponse()
        } catch {
            print(error)
        }
    }
    
    private func handleResponse() {
        for var i = 0; i<self.dataDict!["births"]!.count; ++i {
            let birth = self.dataDict!["births"]![i]
            births.append(Birth(person: birth.allValues.first! as! String, year: birth.allKeys.first!.integerValue))
        }
        
        for var i = 0; i<self.dataDict!["deaths"]!.count; ++i {
            let death = self.dataDict!["deaths"]![i]
            deaths.append(Death(person: death.allValues.first! as! String, year: death.allKeys.first!.integerValue))
        }
        
        for var i = 0; i<self.dataDict!["events"]!.count; ++i {
            let event = self.dataDict!["events"]![i]
            events.append(Event(description: event.allValues.first! as! String, year: event.allKeys.first!.integerValue))
        }
    }
}
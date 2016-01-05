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
    
    var births:[Day]
    var deaths:[Day]
    var events:[Day]
    
    init() {
        self.births = [Day]()
        self.deaths = [Day]()
        self.events = [Day]()
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
        urlPath = "http://127.0.0.1:5000/onthisday/\(month)/\(day)"
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
    
    func getHistory(type: Int) -> [Day] {
        return [births,deaths,events][type]
    }
    
    private func fillData(inout array: [Day], key: String) {
        for var i = 0; i<self.dataDict![key]!.count; ++i {
            let data = self.dataDict![key]![i]
            array.append(Day(information: data.allValues.first! as! String, year: data.allKeys.first!.integerValue))
        }
    }
    
    private func handleResponse() {
        fillData(&births, key: "births")
        fillData(&deaths, key: "deaths")
        fillData(&events, key: "events")
    }
}
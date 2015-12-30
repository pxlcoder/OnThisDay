//
//  Event.swift
//  OnThisDay
//
//  Created by Aditya Keerthi on 2015-12-30.
//  Copyright © 2015 Aditya Keerthi. All rights reserved.
//

import Foundation

class Event {
    var year: Int
    var description: String
    
    init(description: String, year: Int){
        self.description = description
        self.year = year
    }
}
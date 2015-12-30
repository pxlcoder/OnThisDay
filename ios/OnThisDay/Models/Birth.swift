//
//  Birth.swift
//  OnThisDay
//
//  Created by Aditya Keerthi on 2015-12-30.
//  Copyright © 2015 Aditya Keerthi. All rights reserved.
//

import Foundation

class Birth {
    var year: Int
    var person: String
    
    init(person: String, year: Int) {
        self.person = person
        self.year = year
    }
}
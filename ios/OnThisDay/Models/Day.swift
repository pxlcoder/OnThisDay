//
//  Day.swift
//  OnThisDay
//
//  Created by Aditya Keerthi on 2016-01-05.
//  Copyright © 2016 Aditya Keerthi. All rights reserved.
//

import Foundation

class Day {
    var year: Int
    var information: String
    
    init(information: String, year: Int) {
        self.year = year
        self.information = information
    }
}

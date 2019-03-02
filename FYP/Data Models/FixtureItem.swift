//
//  FixtureItem.swift
//  FYP
//
//  Created by Project  on 02/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit

class FixtureItem {
    var homeTeam: String
    var awayTeam: String
    var date: String
    var time: String
    
    init(homeTeam: String, awayTeam: String, date: String, time: String) {
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
        self.date = date
        self.time = time
    }
}

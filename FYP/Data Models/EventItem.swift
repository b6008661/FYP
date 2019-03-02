//
//  EventItem.swift
//  FYP
//
//  Created by Project  on 02/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit

class EventItem {
    var type: String
    var name: String
    var player: String
    var time: String
    var period: String
    var team: String
    
    init(type: String, name: String, player: String, time: String, period: String, team: String) {
        self.type = type
        self.name = name
        self.player = player
        self.time = time
        self.period = period
        self.team = team
    }
}

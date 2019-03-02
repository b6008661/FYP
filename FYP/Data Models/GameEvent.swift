//
//  GameEvent.swift
//  FYP
//
//  Created by Project  on 02/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit

class GameEventItem {
    var type: String
    var player: String
    var period: String
    
    init(type: String, player: String, period: String) {
        self.type = type
        self.player = player
        self.period = period
    }
}

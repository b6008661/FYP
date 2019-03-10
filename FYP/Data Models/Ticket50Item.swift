//
//  Ticket50Item.swift
//  FYP
//
//  Created by Project  on 10/03/2019.
//  Copyright © 2019 Claire Smith. All rights reserved.
//

import UIKit

class Ticket50Item {
    var id: Int
    var owner: String
    var fixtureID: Int
    
    init(id: Int, owner: String, fixtureID: Int) {
        self.id = id
        self.owner = owner
        self.fixtureID = fixtureID
    }
}

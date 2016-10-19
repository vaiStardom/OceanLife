//
//  OceanLifeUser.swift
//  OceanLife
//
//  Created by Paul Addy on 2016-10-19.
//  Copyright © 2016 Paul Addy. All rights reserved.
//

import Foundation

class OceanLifeUser {
    static let sharedInstance = OceanLifeUser()

    fileprivate var currentOceanLifeIndex: Int?
    
    var givenCurrentOceanLifeIndex: Int {
        get { return currentOceanLifeIndex! }
        set {
            currentOceanLifeIndex = newValue
        }
    }
    
    fileprivate init() {  // <-- Force callers to use the singleton.
    }
}

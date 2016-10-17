//
//  OceanLifeSpecies.swift
//  OceanLife
//
//  Created by Paul Addy on 2016-10-17.
//  Copyright © 2016 Paul Addy. All rights reserved.
//

import Foundation

class OceanLifeSpecies {

    fileprivate var name: String?
    fileprivate var pictureFile: String?
    
    var givenName: String {
        get { return name! }
        set {
            name = newValue
        }
    }
    
    var givenPictureFile: String {
        get { return pictureFile! }
        set {
            pictureFile = newValue
        }
    }
    
    init(name: String, pictureFile: String) {
        self.name = name
        self.pictureFile = pictureFile
    }
}

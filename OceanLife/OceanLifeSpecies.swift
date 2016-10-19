//
//  OceanLifeSpecies.swift
//  OceanLife
//
//  Created by Paul Addy on 2016-10-17.
//  Copyright © 2016 Paul Addy. All rights reserved.
//

import Foundation

var SPECIES: [OceanLifeSpecies] = [
    OceanLifeSpecies(name: "Batfish", pictureFile: "Batfish", wikipediaLink: "https://en.wikipedia.org/wiki/Ephippidae")
    ,OceanLifeSpecies(name: "Coral", pictureFile: "Coral", wikipediaLink: "https://en.wikipedia.org/wiki/Coral")
    ,OceanLifeSpecies(name: "Cowrie", pictureFile: "Cowrie", wikipediaLink: "https://en.wikipedia.org/wiki/Cowry")
    ,OceanLifeSpecies(name: "Frogfish", pictureFile: "Frogfish", wikipediaLink: "https://en.wikipedia.org/wiki/Frogfish")
    ,OceanLifeSpecies(name: "Nudibranch", pictureFile: "Nudibranch", wikipediaLink: "https://en.wikipedia.org/wiki/Nudibranch")
    ,OceanLifeSpecies(name: "Porcupinefish", pictureFile: "Porcupinefish", wikipediaLink: "https://en.wikipedia.org/wiki/Porcupinefish")
    ,OceanLifeSpecies(name: "ShrimpCoral", pictureFile: "ShrimpCoral", wikipediaLink: "https://nl.wikipedia.org/wiki/Xenocarcinus_tuberculatus")
]

class OceanLifeSpecies {

    fileprivate var name: String?
    fileprivate var pictureFile: String?
    fileprivate var wikipediaLink: String?
    
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

    var givenWikipediaLink: String {
        get { return wikipediaLink! }
        set {
            wikipediaLink = newValue
        }
    }
    
    init(name: String, pictureFile: String, wikipediaLink: String) {
        self.givenName = name
        self.givenPictureFile = pictureFile
        self.givenWikipediaLink = wikipediaLink
    }
}

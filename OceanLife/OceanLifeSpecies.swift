//
//  OceanLifeSpecies.swift
//  OceanLife
//
//  Created by Paul Addy on 2016-10-17.
//  Copyright © 2016 Paul Addy. All rights reserved.
//

import Foundation

var SPECIES: [OceanLifeSpecies] = [
    OceanLifeSpecies(name: "Batfish", pictureFile: "Batfish", wikipediaLink: "https://en.wikipedia.org/wiki/Ephippidae", cellImageLink: "http://media.eol.org/content/2014/10/04/08/08575_orig.jpg")
    ,OceanLifeSpecies(name: "Coral", pictureFile: "Coral", wikipediaLink: "https://en.wikipedia.org/wiki/Coral", cellImageLink: "http://media.eol.org/content/2013/11/03/02/23834_orig.jpg")
    ,OceanLifeSpecies(name: "Cowrie", pictureFile: "Cowrie", wikipediaLink: "https://en.wikipedia.org/wiki/Cowry", cellImageLink: "http://media.eol.org/content/2011/12/27/01/38699_orig.jpg")
    ,OceanLifeSpecies(name: "Frogfish", pictureFile: "Frogfish", wikipediaLink: "https://en.wikipedia.org/wiki/Frogfish", cellImageLink: "http://media.eol.org/content/2009/05/21/16/55036_orig.jpg")
    ,OceanLifeSpecies(name: "Nudibranch", pictureFile: "Nudibranch", wikipediaLink: "https://en.wikipedia.org/wiki/Nudibranch", cellImageLink: "http://media.eol.org/content/2011/10/14/15/97777_orig.jpg")
    ,OceanLifeSpecies(name: "Porcupinefish", pictureFile: "Porcupinefish", wikipediaLink: "https://en.wikipedia.org/wiki/Porcupinefish", cellImageLink: "http://media.eol.org/content/2009/05/19/14/97207_orig.jpg")
    ,OceanLifeSpecies(name: "ShrimpCoral", pictureFile: "ShrimpCoral", wikipediaLink: "https://nl.wikipedia.org/wiki/Xenocarcinus_tuberculatus", cellImageLink: "http://media.eol.org/content/2013/11/24/23/62748_orig.jpg")
]

class OceanLifeSpecies {

    fileprivate var name: String?
    fileprivate var pictureFile: String?
    fileprivate var wikipediaLink: String?
    fileprivate var cellImageLink: String?
    fileprivate var picturePath: String?
    
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
    var givenCellImageLink: String {
        get { return cellImageLink! }
        set {
            cellImageLink = newValue
        }
    }
    init(name: String, pictureFile: String, wikipediaLink: String, cellImageLink: String) {
        self.givenName = name
        self.givenPictureFile = pictureFile
        self.givenWikipediaLink = wikipediaLink
        self.givenCellImageLink = cellImageLink
    }
}

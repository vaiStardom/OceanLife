//
//  OceanLifeSpecies.swift
//  OceanLife
//
//  Created by Paul Addy on 2016-10-17.
//  Copyright © 2016 Paul Addy. All rights reserved.
//

import CoreData
import Foundation
import UIKit

class OceanLifeSpecies {
    
    fileprivate var name: String?
    fileprivate var cellImage: UIImage? //make this an array of images names [String] in case there are alternate pictures, and also the images will be loaded in the app for the first releadse
    fileprivate var cellImageLink: String?
    fileprivate var family: String?
    fileprivate var parentFamily: String?
    fileprivate var color: UIColor?
    
    var thisName: String? {
        get { return name! }
        set {
            name = newValue
        }
    }
    var thisCellImage: UIImage? {
        get { return cellImage }
        set {
            cellImage = newValue
        }
    }
    var thisCellImageLink: String {
        get { return cellImageLink! }
        set {
            cellImageLink = newValue
        }
    }
    var thisFamily: String? {
        get { return family }
        set {
            family = newValue
        }
    }
    var thisParentFamily: String? {
        get { return parentFamily }
        set {
            parentFamily = newValue
        }
    }
    var thisColor: UIColor? {
        get { return color }
        set {
            color = newValue
        }
    }
    init(name: String?
        , cellImage: UIImage?
        , cellImageLink: String
        , family: String?
        , parentFamily: String?
        , color: UIColor?
        ) {
        self.thisName = name
        self.thisCellImage = cellImage
        self.thisCellImageLink = cellImageLink
        self.thisFamily = family
        self.thisParentFamily = parentFamily
        self.thisColor = color
    }
}

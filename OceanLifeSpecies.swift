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
    fileprivate var cellImage: UIImage?
    fileprivate var cellImageLink: String?
    fileprivate var familly: String?
    fileprivate var parentFamilly: String?
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
    var thisFamilly: String? {
        get { return familly }
        set {
            familly = newValue
        }
    }
    var thisParentFamilly: String? {
        get { return parentFamilly }
        set {
            parentFamilly = newValue
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
        , familly: String?
        , parentFamilly: String?
        , color: UIColor?
        ) {
        self.thisName = name
        self.thisCellImage = cellImage
        self.thisCellImageLink = cellImageLink
        self.thisFamilly = familly
        self.thisParentFamilly = parentFamilly
        self.thisColor = color
    }
}

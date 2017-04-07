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

class OceanLifeSpecies: Hashable, Equatable {
    
    private static let idGenerator = OceanLifeHashableIdGenerator()
    
    fileprivate var imageNames = [String]() //array of images names [String] for alternate pics
    fileprivate var name: String?
    fileprivate var nameLatin: String?    
    fileprivate var parentFamily: String?
    fileprivate var desc: String?
    fileprivate let id: Int
    
    var hashValue: Int{
        return id
    }
    var thisImageNames: [String] {
        get { return imageNames }
        set {
            imageNames = newValue
        }
    }
    var thisName: String? {
        get { return name! }
        set {
            name = newValue
        }
    }
    var thisNameLatin: String? {
        get { return nameLatin! }
        set {
            nameLatin = newValue
        }
    }
    var thisParentFamily: String? {
        get { return parentFamily }
        set {
            parentFamily = newValue
        }
    }
    var thisDescription: String? {
        get { return desc }
        set {
            desc = newValue
        }
    }
    init(imageNames: [String]
        , name: String?
        , nameLatin: String?
        , parentFamily: String?
        , description: String?
        ) {
        self.id = OceanLifeSpecies.idGenerator.generate()
        self.thisImageNames = imageNames
        self.thisName = name
        self.thisNameLatin = nameLatin
        self.thisParentFamily = parentFamily
        self.thisDescription = description
    }
    init(oceanLifeSpecie: OceanLifeSpecies) {
        self.id = OceanLifeSpecies.idGenerator.generate()
        self.thisImageNames = oceanLifeSpecie.thisImageNames
        self.thisName = oceanLifeSpecie.thisName
        self.thisNameLatin = oceanLifeSpecie.thisNameLatin
        self.thisParentFamily = oceanLifeSpecie.thisParentFamily
        self.thisDescription = oceanLifeSpecie.thisDescription
    }
}
func ==(oceanLifeSpecies1: OceanLifeSpecies, oceanLifeSpecies2: OceanLifeSpecies) -> Bool {
        return oceanLifeSpecies1 === oceanLifeSpecies2
}
extension OceanLifeSpecies: CustomStringConvertible { //this extension allows for better debugging
    var description: String {
        let name = (self.thisName != nil ? self.thisName! : ">>>>NIL<<<<<")
        let nameLatin = (self.thisNameLatin != nil ? self.thisNameLatin! : ">>>>NIL<<<<<")
        let parentFamily = (self.thisParentFamily != nil ? self.thisParentFamily! : ">>>>NIL<<<<<")
        let text = "Name -> \(name) nameLatin -> \(nameLatin) parentFamily -> \(parentFamily)"
        return text
    }
}

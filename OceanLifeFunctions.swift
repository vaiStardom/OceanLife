//
//  OceanLifeFunctions.swift
//  OceanLife
//
//  Created by Paul Addy on 3/19/17.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

func BUILD_FAMILY_TREE(ofThisNode: inout OceanLifeSpecieNode) {
    let childrenSpecies = SPECIES.filter{ $0.thisParentFamily == ofThisNode.name }
    if childrenSpecies.count > 0 {
        for specie in childrenSpecies {
            var node = OceanLifeSpecieNode(name: specie.thisName!, id: specie.hashValue)
            //print("------> WILL BUILD NODE: \(specie.thisName!)")
            BUILD_FAMILY_TREE(ofThisNode: &node)
            //print("------> BUILT NODE: \(node)")
            ofThisNode.add(child: node)
        }
    }
}

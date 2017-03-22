//
//  OceanLifeFunctions.swift
//  OceanLife
//
//  Created by Paul Addy on 3/19/17.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

func countSubSpecies(oceanLifeSpecies: OceanLifeSpecies){
    let parent = oceanLifeSpecies.thisParentFamily != nil ? oceanLifeSpecies.thisParentFamily! : ""
    let family = oceanLifeSpecies.thisFamily != nil ? oceanLifeSpecies.thisFamily! : ""
    let specie = oceanLifeSpecies.thisName != nil ? oceanLifeSpecies.thisName! : ""
    let entry = "\(parent)\(family)\(specie)"

    //has this entry been counted?
    //let evaluatedSpecies = countedSpecies.filter{ $0 == entry }
    //let evaluatedSpecies = countedSpecies.filter{ $0.contains(entry) }
    let evaluatedSpecies = countedSpecies.contains(entry)
    
    //if evaluatedSpecies.count > 0 {
    if countedSpecies.contains(entry) {
        print("ALREADY COUNTED entry: \(entry)")
        return
    } else {
        numberOfSubspecies += 1

        countedSpecies.append(String(entry))
        print("COUNTED specie: \(entry)")
        print("numberOfSubspecies: \(numberOfSubspecies)")

        //check to see if this entry has subspecies
        let subSpecies = masterFamillies.filter{ $0.thisParentFamily == family}
        if subSpecies.count > 0 {
            print("ENTRY \(entry) HAS \(subSpecies.count) SUBSPECIES")
            for thisOceanLife in subSpecies {
                countSubSpecies(oceanLifeSpecies: thisOceanLife)
            }
        }
    }
}

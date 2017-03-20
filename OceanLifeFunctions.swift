//
//  OceanLifeFunctions.swift
//  OceanLife
//
//  Created by Paul Addy on 3/19/17.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

var countedSpecies = [String]()
var numberOfSubspecies = 0

func countSubSpecies(oceanLifeSpecies: OceanLifeSpecies){
    let parent = oceanLifeSpecies.thisParentFamily != nil ? oceanLifeSpecies.thisParentFamily! : ""
    let family = oceanLifeSpecies.thisFamily != nil ? oceanLifeSpecies.thisFamily! : ""
    let specie = oceanLifeSpecies.thisName != nil ? oceanLifeSpecies.thisName! : ""
    let entry = "\(parent)\(family)\(specie)"

    //has this entry been counted?
    let evaluatedSpecies = countedSpecies.filter{ $0 == entry}
    if evaluatedSpecies.count > 0 {
//        print("ALREADY COUNTED entry: \(entry)")
        return
    } else {
        numberOfSubspecies += 1
        
        countedSpecies.append(entry)
//        print("COUNTED specie: \(entry)")
//        print("numberOfSubspecies: \(numberOfSubspecies)")
        
        //check to see if this entry has subspecies
        let subSpecies = masterFamillies.filter{ $0.thisParentFamily == family}
        if subSpecies.count > 0 {
//            print("ENTRY \(entry) HAS \(subSpecies.count) SUBSPECIES")
            for thisOceanLife in subSpecies {
                countSubSpecies(oceanLifeSpecies: thisOceanLife)
            }
        }
    }
}

//func countSubSpecies(oceanLifeSpecies: OceanLifeSpecies){
//    let parent = oceanLifeSpecies.thisParentFamily != nil ? oceanLifeSpecies.thisParentFamily! : ""
//    let family = oceanLifeSpecies.thisFamily != nil ? oceanLifeSpecies.thisFamily! : ""
//    let specie = oceanLifeSpecies.thisName != nil ? oceanLifeSpecies.thisName! : ""
//    let entry = "\(parent)\(family)\(specie)"
//    let evaluatedSpecies = countedSpecies.filter{ $0 == entry}
//    if evaluatedSpecies.count > 0 {
//        print("EVALUATED specie: \(entry)")
//        return
//    } else {
//        countedSpecies.append(entry)
//    }
//    let subSpecies = masterFamillies.filter{ $0.thisParentFamily == oceanLifeSpecies.thisFamily}
//    if subSpecies.count > 0 {
//        //numberOfSubspecies += subSpecies.count
//        for thisOceanLife in subSpecies {
//            numberOfSubspecies += 1
//            print("COUNTED specie: \(entry)")
//            countSubSpecies(oceanLifeSpecies: thisOceanLife)
//        }
//    }
//}

//func countSubSpecies(oceanLifeSpecies: OceanLifeSpecies){
//    let evaluatedSpecies = countedSpecies.filter{ $0 == oceanLifeSpecies.thisFamilly}
//    if evaluatedSpecies.count > 0 {
//        return
//    } else {
//        countedSpecies.append(oceanLifeSpecies.thisFamilly!)
//    }
//    let subSpecies = masterFamillies.filter{ $0.thisParentFamilly == oceanLifeSpecies.thisFamilly}
//    if subSpecies.count > 0 {
//        //numberOfSubspecies += subSpecies.count
//        for thisOceanLife in subSpecies {
//            numberOfSubspecies += 1
//            countSubSpecies(oceanLifeSpecies: thisOceanLife)
//        }
//    }
//}

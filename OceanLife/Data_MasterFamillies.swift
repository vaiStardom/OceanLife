////
////  DataToLoad.swift
////  OceanLife
////
////  Created by Paul Addy on 2016-10-26.
////  Copyright © 2016 Paul Addy. All rights reserved.
////
//

import UIKit

var masterFamillies: [OceanLifeSpecies] = [
    OceanLifeSpecies(
        name: "Corals"
        , cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2013/11/03/02/23834_orig.jpg"
        , familly: "Coral"
        , parentFamilly: nil
        , color: UIColor.black
    )

    ,     OceanLifeSpecies(
        name: "Sponge 1"
        , cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2013/11/03/02/23834_orig.jpg"
        , familly: "Sponge"
        , parentFamilly: "Coral"
        , color: UIColor.darkGray
    )
    
    ,     OceanLifeSpecies(
        name: "Sponge 2"
        , cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2013/11/03/02/23834_orig.jpg"
        , familly: "Sponge"
        , parentFamilly: "Coral"
        , color: UIColor.darkGray
    )

    
    ,     OceanLifeSpecies(
        name: "Sponge 3"
        , cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2013/11/03/02/23834_orig.jpg"
        , familly: "Sponge"
        , parentFamilly: "Coral"
        , color: UIColor.darkGray
    )


    ,     OceanLifeSpecies(
        name: "Blue Sponge 1"
        , cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2013/11/03/02/23834_orig.jpg"
        , familly: "Blue Sponge"
        , parentFamilly: "Sponge"
        , color: UIColor.blue
    )

    
    ,     OceanLifeSpecies(
        name: "White Sponge 1"
        , cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2013/11/03/02/23834_orig.jpg"
        , familly: "White Sponge"
        , parentFamilly: "Sponge"
        , color: UIColor.white
    )

    
    
    ,     OceanLifeSpecies(
        name: "Red Sponge 1"
        , cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2013/11/03/02/23834_orig.jpg"
        , familly: "Red Sponge"
        , parentFamilly: "Sponge"
        , color: UIColor.red
    )


    ,     OceanLifeSpecies(
        name: "Red Sponge 1-1"
        , cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2013/11/03/02/23834_orig.jpg"
        , familly: "Red Sponge 1"
        , parentFamilly: "Red Sponge"
        , color: UIColor.red
    )


    ,     OceanLifeSpecies(
        name: "Red Sponge 2-1"
        , cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2013/11/03/02/23834_orig.jpg"
        , familly: "Red Sponge 2"
        , parentFamilly: "Red Sponge"
        , color: UIColor.red
    )


    ,     OceanLifeSpecies(
        name: "Red Sponge 3-1"
        , cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2013/11/03/02/23834_orig.jpg"
        , familly: "Red Sponge 3"
        , parentFamilly: "Red Sponge"
        , color: UIColor.red
    )


    ,     OceanLifeSpecies(
        name: "Bob Sponge 1"
        , cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2013/11/03/02/23834_orig.jpg"
        , familly: "Bob Sponge"
        , parentFamilly: "Coral"
        , color: UIColor.yellow
    )

    
    ,     OceanLifeSpecies(
        name: "Bob Sponge 2"
        , cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2013/11/03/02/23834_orig.jpg"
        , familly: "Bob Sponge"
        , parentFamilly: "Coral"
        , color: UIColor.yellow
    )

    
    ,     OceanLifeSpecies(
        name: "Bob Sponge 3"
        , cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2013/11/03/02/23834_orig.jpg"
        , familly: "Bob Sponge"
        , parentFamilly: "Coral"
        , color: UIColor.yellow
    )


    ,     OceanLifeSpecies(
        name: "Butterfly fish"
        , cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2013/11/03/02/23834_orig.jpg"
        , familly: "Butterfly fish"
        , parentFamilly: nil
        , color: UIColor.green
    )


//    , OceanLifeSpecies(
//        cellImage: nil
//        , cellImageLink: "http://media.eol.org/content/2015/07/03/10/39814_orig.jpg"
//        , commonName: "Butterflyfish"
//        , icunRedListCategory: nil
//        , parentFamilly: nil
//        , taxonomy: "Chaetodontidae"
//        , wikipediaLink: "https://en.wikipedia.org/wiki/Butterflyfish")
//    , OceanLifeSpecies(
//        cellImage: nil
//        , cellImageLink: "http://media.eol.org/content/2009/05/21/16/56747_orig.jpg"
//        , commonName: "Benthic Predatory"
//        , icunRedListCategory: nil
//        , parentFamilly: nil
//        , taxonomy: "Benthic Predatory"
//        , wikipediaLink: "https://en.wikipedia.org/wiki/Wrasse")
//    , OceanLifeSpecies(
//        cellImage: nil
//        , cellImageLink: "http://media.eol.org/content/2014/10/09/10/66013_orig.jpg"
//        , commonName: "Reef Herbivorous"
//        , icunRedListCategory: nil
//        , parentFamilly: nil
//        , taxonomy: "Reef Herbivorous"
//        , wikipediaLink: "https://en.wikipedia.org/wiki/Coral_reef_fish#Herbivores")
//    , OceanLifeSpecies(
//        cellImage: nil
//        , cellImageLink: "http://media.eol.org/content/2016/07/21/01/30824_orig.jpg"
//        , commonName: "Pelagic"
//        , icunRedListCategory: nil
//        , parentFamilly: nil
//        , taxonomy: "Pelagic"
//        , wikipediaLink: "https://en.wikipedia.org/wiki/Pelagic_fish")
]


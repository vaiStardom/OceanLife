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

var dataToLoad: [OceanLifeSpecies] = [
    OceanLifeSpecies(
        cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2013/11/03/02/23834_orig.jpg"
        , commonName: "Coral"
        , taxonomy: "Corals"
        , wikipediaLink: "https://en.wikipedia.org/wiki/Coral")
    , OceanLifeSpecies(
        cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2015/07/03/10/39814_orig.jpg"
        , commonName: "Butterflyfish"
        , taxonomy: "Chaetodontidae"
        , wikipediaLink: "https://en.wikipedia.org/wiki/Butterflyfish")
    , OceanLifeSpecies(
        cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2009/05/21/16/56747_orig.jpg"
        , commonName: "Benthic Predatory"
        , taxonomy: "Benthic Predatory"
        , wikipediaLink: "https://en.wikipedia.org/wiki/Wrasse")
    , OceanLifeSpecies(
        cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2014/10/09/10/66013_orig.jpg"
        , commonName: "Reef Herbivorous"
        , taxonomy: "Reef Herbivorous"
        , wikipediaLink: "https://en.wikipedia.org/wiki/Coral_reef_fish#Herbivores")
    , OceanLifeSpecies(
        cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2016/07/21/01/30824_orig.jpg"
        , commonName: "Pelagic"
        , taxonomy: "Pelagic"
        , wikipediaLink: "https://en.wikipedia.org/wiki/Pelagic_fish")
    , OceanLifeSpecies(
        cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2011/10/14/15/97777_orig.jpg"
        , commonName: "Nudibranch"
        , taxonomy: "Nudibranchia"
        , wikipediaLink: "https://en.wikipedia.org/wiki/Nudibranch")
    , OceanLifeSpecies(
        cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2009/05/19/14/97207_orig.jpg"
        , commonName: "Porcupinefish"
        , taxonomy: "Diodon antennatus"
        , wikipediaLink: "https://en.wikipedia.org/wiki/Porcupinefish")
    , OceanLifeSpecies(
        cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2013/11/24/23/62748_orig.jpg"
        , commonName: "ShrimpCoral"
        , taxonomy: "Conical Spider Crab"
        , wikipediaLink: "https://nl.wikipedia.org/wiki/Xenocarcinus_tuberculatus")
]

class OceanLifeSpecies {
    
    fileprivate var cellImage: UIImage?
    fileprivate var cellImageLink: String?
    fileprivate var commonName: String?
    fileprivate var taxonomy: String?
    fileprivate var wikipediaLink: String?
    
    var givenCellImage: UIImage? {
        get { return cellImage }
        set {
            if newValue != nil {
                cellImage = newValue
            } else {
                cellImage = nil
            }
        }
    }
    var givenCellImageLink: String {
        get { return cellImageLink! }
        set {
            cellImageLink = newValue
        }
    }
    var givenCommonName: String {
        get { return commonName! }
        set {
            commonName = newValue
        }
    }
    var givenTaxonomy: String {
        get { return taxonomy! }
        set {
            taxonomy = newValue
        }
    }
    var givenWikipediaLink: String {
        get { return wikipediaLink! }
        set {
            wikipediaLink = newValue
        }
    }
    init(cellImage: UIImage?, cellImageLink: String, commonName: String, taxonomy: String, wikipediaLink: String) {
        self.givenCellImage = cellImage
        self.givenCellImageLink = cellImageLink
        self.givenCommonName = commonName
        self.givenTaxonomy = taxonomy
        self.givenWikipediaLink = wikipediaLink
    }
    static func getContext() -> NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    static func getSpecies() -> [Species] {
        let context = getContext()
        let fetchRequest: NSFetchRequest<Species> = NSFetchRequest(entityName: "Species")
        var fetchResults: [Species] = []
        do {
            fetchResults = try context.fetch(fetchRequest)
            print("Fetched \(fetchResults.count) species")
            
        } catch  {
            print("Failed fetching all the species")
        }
        return fetchResults
    }
    
    static func updateSpecies(species: OceanLifeSpecies) {
        
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Species", in: context)
        let options = NSManagedObject(entity: entity!, insertInto:context)
        
        var cellImage: Data? = nil
        cellImage = (species.cellImage != nil ? UIImagePNGRepresentation(species.cellImage!)! as Data : nil)
        
        options.setValue(cellImage, forKey: "cellImage")
        options.setValue(species.cellImageLink, forKey: "cellImageLink")
        options.setValue(species.commonName, forKey: "commonName")
        options.setValue(species.taxonomy, forKey: "taxonomy")
        options.setValue(species.wikipediaLink, forKey: "wikipediaLink")
        
        do {
            try context.save()
            print("Saved species: \(species.commonName)")
        } catch {
            print("Failed to save species: \(error)")
        }
    }
    
    static func emptySpecies(){
        let context = getContext()
        let fetchRequest: NSFetchRequest<Species> = NSFetchRequest(entityName: "Species")
        var fetchResults: [Species] = []
        do {
            fetchResults = try context.fetch(fetchRequest)
            for result in fetchResults{
                context.delete(result)
                do {
                    try context.save()
                } catch {
                    print("Error trying to delete record \(result.taxonomy)")
                }
            }
            print("Deleted \(fetchResults.count) species")
            
        } catch  {
            print("Failed fetching all the species")
        }
    }
    
    static func updateOceanSpecieCellImage(species: Species) {
        let context = getContext()
        let predicate = NSPredicate(format: "taxonomy == %@ ", argumentArray: [species.taxonomy])
        let fetchRequest: NSFetchRequest<Species> = NSFetchRequest(entityName: "Species")
        var fetchResults: [Species] = []
        
        fetchRequest.predicate = predicate
        
        do {
            fetchResults = try context.fetch(fetchRequest)
            var cellImage: Data? = nil
            cellImage = (species.cellImage != nil ? species.cellImage! as Data : nil)
            fetchResults.first?.cellImage = cellImage as NSData?
            print("Updated cell image of \(species.commonName) specie")
        } catch  {
            print("Error updating cell image of \(species.commonName) specie")
        }
        
        do {
            try context.save()
            print("Saved cell image of \(species.commonName) specie")
        } catch  {
            print("Error saving cell image of \(species.commonName) specie")
        }
    }
    
    static func isSpecieExist(taxonomy: String) -> Bool? {
        let context = getContext()
        let predicate = NSPredicate(format: "taxonomy == %@ ", argumentArray: [taxonomy])
        let fetchRequest: NSFetchRequest<Species> = NSFetchRequest(entityName: "Species")
        var fetchResults: [Species] = []
        fetchRequest.predicate = predicate
        var exists: Bool? = false
        
        do {
            fetchResults = try context.fetch(fetchRequest)
            if fetchResults.count > 0 {
                print("Species \(fetchResults.first?.commonName) exists.")
                exists = true
            } else {
                print("Species \(fetchResults.first?.commonName) does not exists.")
                exists =  false
            }
        } catch  {
            print("Error looking for \(taxonomy) specie")
        }
        return exists
    }
}

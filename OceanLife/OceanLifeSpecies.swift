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
        , cellImageLink: "http://media.eol.org/content/2014/10/04/08/08575_orig.jpg"
        , commonName: "Batfish"
        , imageFile: "Batfish"
        , imagePath: nil
        , latinName: "Ephippidae"
        , wikipediaLink: "https://en.wikipedia.org/wiki/Ephippidae")
    , OceanLifeSpecies(
        cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2013/11/03/02/23834_orig.jpg"
        , commonName: "Coral"
        , imageFile: "Coral"
        , imagePath: nil
        , latinName: "Zoophyta"
        , wikipediaLink: "https://en.wikipedia.org/wiki/Coral")
    , OceanLifeSpecies(
        cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2011/12/27/01/38699_orig.jpg"
        , commonName: "Cowrie"
        , imageFile: "Cowrie"
        , imagePath: nil
        , latinName: "Cypraeidae"
        , wikipediaLink: "https://en.wikipedia.org/wiki/Cypraeidae")
    , OceanLifeSpecies(
        cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2009/05/21/16/55036_orig.jpg"
        , commonName: "Frogfish"
        , imageFile: "Frogfish"
        , imagePath: nil
        , latinName: "Lophiiformes"
        , wikipediaLink: "https://en.wikipedia.org/wiki/Anglerfish")
    , OceanLifeSpecies(
        cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2011/10/14/15/97777_orig.jpg"
        , commonName: "Nudibranch"
        , imageFile: "Nudibranch"
        , imagePath: nil
        , latinName: "Nudibranchia"
        , wikipediaLink: "https://en.wikipedia.org/wiki/Nudibranch")
    , OceanLifeSpecies(
        cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2009/05/19/14/97207_orig.jpg"
        , commonName: "Porcupinefish"
        , imageFile: "Porcupinefish"
        , imagePath: nil
        , latinName: "Diodon antennatus"
        , wikipediaLink: "https://en.wikipedia.org/wiki/Porcupinefish")
    , OceanLifeSpecies(
        cellImage: nil
        , cellImageLink: "http://media.eol.org/content/2013/11/24/23/62748_orig.jpg"
        , commonName: "ShrimpCoral"
        , imageFile: "ShrimpCoral"
        , imagePath: nil
        , latinName: "Conical Spider Crab"
        , wikipediaLink: "https://nl.wikipedia.org/wiki/Xenocarcinus_tuberculatus")
]

class OceanLifeSpecies {
    
    fileprivate var cellImage: UIImage?
    fileprivate var cellImageLink: String?
    fileprivate var commonName: String?
    fileprivate var imageFile: String?
    fileprivate var imagePath: String?
    fileprivate var latinName: String?
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
    var givenImageFile: String {
        get { return imageFile! }
        set {
            imageFile = newValue
        }
    }
    var givenImagePath: String? {
        get { return imagePath! }
        set {
            if newValue != nil {
                imagePath = newValue
            } else {
                imagePath = nil
            }   
        }
    }
    var givenLatinName: String {
        get { return latinName! }
        set {
            latinName = newValue
        }
    }
    var givenWikipediaLink: String {
        get { return wikipediaLink! }
        set {
            wikipediaLink = newValue
        }
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
        options.setValue(species.imageFile, forKey: "imageFile")
        options.setValue(species.imagePath, forKey: "imagePath")
        options.setValue(species.latinName, forKey: "latinName")
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
                    print("Error trying to delete record \(result.latinName)")
                }
            }
            print("Deleted \(fetchResults.count) species")
            
        } catch  {
            print("Failed fetching all the species")
        }
    }
    
    static func searchOceanSpecies(latinName: String) throws -> [Species]?{
        let context = getContext()
        let searchRequest: NSFetchRequest<Species> = Species.fetchRequest()
        searchRequest.predicate = NSPredicate(format: "latinName == %@ ", argumentArray: [latinName])
        do {
            return try context.fetch(searchRequest)
        } catch {
            print("Somothing went wrong")
            return nil
        }
    }
    
    init(cellImage: UIImage?, cellImageLink: String, commonName: String, imageFile: String, imagePath: String?, latinName: String, wikipediaLink: String) {
        self.givenCellImage = cellImage
        self.givenCellImageLink = cellImageLink
        self.givenCommonName = commonName
        self.givenImageFile = imageFile
        self.givenImagePath = imagePath
        self.givenLatinName = latinName
        self.givenWikipediaLink = wikipediaLink
    }
}

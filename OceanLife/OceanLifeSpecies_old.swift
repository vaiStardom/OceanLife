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

class OceanLifeSpecies_old {
    
    fileprivate var cellImage: UIImage?
    fileprivate var cellImageLink: String?
    fileprivate var commonName: String?
    fileprivate var cellDescription: String?
    fileprivate var cellShortDescription: String?
    fileprivate var icunRedListCategory: String?
    fileprivate var familly: String?
    fileprivate var parentFamilly: String?
    fileprivate var informationLink: String?
    
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
    var thisCommonName: String {
        get { return commonName! }
        set {
            commonName = newValue
        }
    }
    var thisCellDescription: String? {
        get { return cellDescription! }
        set {
            cellDescription = newValue
        }
    }
    var thisCellShortDescription: String? {
        get { return cellShortDescription! }
        set {
            cellShortDescription = newValue
        }
    }
    var thisIcunRedListCategory: String? {
        get { return icunRedListCategory! }
        set {
            icunRedListCategory = newValue
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
    var thisInformationLink: String {
        get { return informationLink! }
        set {
            informationLink = newValue
        }
    }
    init(cellImage: UIImage?
        , cellImageLink: String
        , commonName: String
        , cellDescription: String?
        , cellShortDescription: String?
        , icunRedListCategory: String?
        , familly: String?
        , parentFamilly: String?
        , informationLink: String) {
        self.thisCellImage = cellImage
        self.thisCellImageLink = cellImageLink
        self.thisCommonName = commonName
        self.thisCellDescription = cellDescription
        self.thisCellShortDescription = cellShortDescription
        self.thisIcunRedListCategory = icunRedListCategory
        self.thisFamilly = familly
        self.thisParentFamilly = parentFamilly
        self.thisInformationLink = informationLink
    }

    static func getContext() -> NSManagedObjectContext {
        //return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return (UIApplication.shared.delegate as! AppDelegate).coreDataManager.persistentContainer.viewContext
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
        //cellImage = (species.cellImage != nil ? UIImagePNGRepresentation(species.cellImage!)! as Data : nil)
        
        options.setValue(cellImage, forKey: "cellImage")
//        options.setValue(species.cellImageLink, forKey: "cellImageLink")
//        options.setValue(species.commonName, forKey: "commonName")
//        options.setValue(species.familly, forKey: "familly")
//        options.setValue(species.informationLink, forKey: "informationLink")
        
        do {
            try context.save()
            //            print("Saved species: \(species.commonName)")
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
                    print("Error trying to delete record \(result.familly)")
                }
            }
            print("Deleted \(fetchResults.count) species")
            
        } catch  {
            print("Failed fetching all the species")
        }
    }
    
    static func updateOceanSpecieCellImage(species: Species) {
        let context = getContext()
        let predicate = NSPredicate(format: "taxonomy == %@ ", argumentArray: [species.familly])
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
    
    static func isSpecieExist(familly: String) -> Bool? {
        let context = getContext()
        let predicate = NSPredicate(format: "taxonomy == %@ ", argumentArray: [familly])
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
            print("Error looking for \(familly) specie")
        }
        return exists
    }
}

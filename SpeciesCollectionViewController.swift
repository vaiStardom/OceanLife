//
//  SpeciesCollectionViewController.swift
//  OceanLife
//
//  Created by Paul Addy on 3/17/17.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class SpeciesCollectionViewController: UICollectionViewController {
    
    var firstParentFamillies = [OceanLifeSpecies]()
    
    
    var numberOfSubspecies = 0
    
    var dictionary: [String:Int] = [:]
    
    var countedSpecieName: String?
    var countedSpecies = [String]()
    
    var dataSources = [UIColor]()
}
//MARK: Actions
extension SpeciesCollectionViewController{
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let famillyChildCollectionViewController = (self.storyboard?.instantiateViewController(withIdentifier: "FamillyChildCollectionViewController"))! as! FamillyChildCollectionViewController
        self.navigationController?.pushViewController(famillyChildCollectionViewController, animated: true)
    }
}
//MARK: Collection view management
extension SpeciesCollectionViewController{
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSources.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor = dataSources[indexPath.row]
        return cell
    }
}
//MARK: Helpers
extension SpeciesCollectionViewController{
    
    func countSubSpecies(oceanLifeSpecies: OceanLifeSpecies){
        
        //print("Now evaluating oceanLifeSpecies.thisFamilly = \(oceanLifeSpecies.thisFamilly)")
        
        var evaluatedSpecies = countedSpecies.filter{ $0 == oceanLifeSpecies.thisFamilly}
        
        if evaluatedSpecies.count > 0 {
            //print("\(evaluatedSpecies[0]) already evaluated, escaping...")
            return
        } else {
            countedSpecies.append(oceanLifeSpecies.thisFamilly!)
            //print("oceanLifeSpecies.thisFamilly! = \(oceanLifeSpecies.thisFamilly!)")
        }
        
        let subSpecies = masterFamillies.filter{ $0.thisParentFamilly == oceanLifeSpecies.thisFamilly}
        if subSpecies.count > 0 {
            
//            print("subSpecies[0].thisParentFamilly = \(subSpecies[0].thisParentFamilly)")
//            print("subSpecies.count = \(subSpecies.count)")
            
            numberOfSubspecies += subSpecies.count
            //            print("numberOfSubspecies = \(numberOfSubspecies)")
            for thisOceanLife in subSpecies {
                //print("counting subspecies of  = \(thisOceanLife.thisFamilly)")
                countSubSpecies(oceanLifeSpecies: thisOceanLife)
            }
        }
//        else {
//            print("subSpecies.count = \(subSpecies.count)")
//        }
    }
}
//MARK: Life-cycle
extension SpeciesCollectionViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstParentFamillies = masterFamillies.filter{ $0.thisParentFamilly == nil }
        //print("firstParentFamillies = \(firstParentFamillies.count)")
        
        for thisOceanLife in firstParentFamillies {
            numberOfSubspecies = 1
            countSubSpecies(oceanLifeSpecies: thisOceanLife)
            dictionary[thisOceanLife.thisFamilly!] = numberOfSubspecies
            numberOfSubspecies = 0
        }
        
        print(dictionary)
        
        dataSources.append(UIColor.black)
        dataSources.append(UIColor.blue)
        dataSources.append(UIColor.brown)
        dataSources.append(UIColor.cyan)
        dataSources.append(UIColor.darkGray)
        dataSources.append(UIColor.green)
        dataSources.append(UIColor.orange)
        dataSources.append(UIColor.purple)
        dataSources.append(UIColor.red)
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

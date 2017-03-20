//
//  FamillyChildCollectionViewController.swift
//  OceanLife
//
//  Created by Paul Addy on 3/17/17.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class FamillyChildCollectionViewController: UICollectionViewController {
    var parentFamily: String!
    
    fileprivate var families = [OceanLifeSpecies]()
    fileprivate var species = [OceanLifeSpecies]()
    fileprivate var dataSources = [UIColor]()
    fileprivate var parentSpeciesDictionary: [String:Int] = [:]
    fileprivate var sortedParentSpeciesDictionary:[(specie: String, numberOfSubspecies: Int)] = []
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
    fileprivate let itemsPerRow: CGFloat = 2
}
//MARK: Actions
extension FamillyChildCollectionViewController{
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if sortedParentSpeciesDictionary[indexPath.row].numberOfSubspecies > 0 {
            //present a new album view
            let famillyChildCollectionViewController = (self.storyboard?.instantiateViewController(withIdentifier: "FamillyChildCollectionViewController"))! as! FamillyChildCollectionViewController
            famillyChildCollectionViewController.parentFamily = sortedParentSpeciesDictionary[indexPath.row].specie
            self.navigationController?.pushViewController(famillyChildCollectionViewController, animated: true)
        } else {
            //present the details of the entry
            
        }

    }
}
//MARK: Collection view management
extension FamillyChildCollectionViewController{
    fileprivate func registerCell() {
        let nib = UINib(nibName: String(describing: SpecieCollectionViewCell.self), bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: SpecieCollectionViewCell.self))
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return parentSpeciesDictionary.count
        return sortedParentSpeciesDictionary.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SpecieCollectionViewCell.self), for: indexPath as IndexPath) as! SpecieCollectionViewCell
        
//        let key = Array(parentSpeciesDictionary.keys)[indexPath.row]
//        let array = parentSpeciesDictionary[key]
//        cell.specieImageView.image = UIImage(named: "testImage")
//        cell.specieNameLabel.text = key
//        cell.numberOfSubspeciesLabel.text = "\(array!)"

        cell.specieImageView.image = UIImage(named: "testImage")
        cell.specieNameLabel.text = sortedParentSpeciesDictionary[indexPath.row].specie
        cell.numberOfSubspeciesLabel.text = "\(sortedParentSpeciesDictionary[indexPath.row].numberOfSubspecies)"

        return cell
    }
}
//MARK: UICollectionViewDelegateFlowLayout
extension FamillyChildCollectionViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: 174)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
//MARK: Life-cycle
extension FamillyChildCollectionViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //SHOW ENTRIES WITH SUB FAMILIES
        //print("SHOW SUBFAMILIES for entry \(parentFamily)")
        families = masterFamillies.filter{ $0.thisParentFamily == parentFamily }
        families = families.sorted(by: { $0.thisFamily?.localizedCaseInsensitiveCompare($1.thisFamily!) == ComparisonResult.orderedAscending })
        countedSpecies = []
        numberOfSubspecies = 0
        var previouslyCountedFamilly = ""
        for thisOceanLife in families {
            //print("COUNTING family : \(thisOceanLife.thisFamily!)")
            if thisOceanLife.thisFamily! != previouslyCountedFamilly {
                numberOfSubspecies = 0
                previouslyCountedFamilly = thisOceanLife.thisFamily!
            }
            countSubSpecies(oceanLifeSpecies: thisOceanLife)
            parentSpeciesDictionary[thisOceanLife.thisFamily!] = numberOfSubspecies
            countedSpecies = []
        }
        
        //SHOW unique for this parent family
        //print("SHOW UNIQUE ENTRIES for entry \(parentFamily)")
        species = masterFamillies.filter{ $0.thisFamily == parentFamily }
        for thisOceanLife in species {
            if thisOceanLife.thisName != thisOceanLife.thisFamily { //exclude the parent family entry description
                parentSpeciesDictionary[thisOceanLife.thisName!] = 0
            }
        }
        
        sortedParentSpeciesDictionary = parentSpeciesDictionary.sorted(by: { (a, b) in (a.value) > (b.value)}) as! [(specie: String, numberOfSubspecies: Int)]
        print(sortedParentSpeciesDictionary)

        registerCell()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

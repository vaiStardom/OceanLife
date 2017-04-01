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
    
    fileprivate var speciesAndSubfamilies = [OceanLifeSpecies]()
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
    func back(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    func search(){
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
        return sortedParentSpeciesDictionary.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SpecieCollectionViewCell.self), for: indexPath as IndexPath) as! SpecieCollectionViewCell
        
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
        speciesAndSubfamilies = masterFamillies.filter{ $0.thisParentFamily == parentFamily }
        speciesAndSubfamilies = speciesAndSubfamilies.sorted(by: { $0.thisFamily?.localizedCaseInsensitiveCompare($1.thisFamily!) == ComparisonResult.orderedAscending })
        
        countedSpecies = []
        numberOfSubspecies = 0
        var previouslyCountedFamilly = ""
        for thisOceanLife in speciesAndSubfamilies {
            //print("COUNTING family : \(thisOceanLife.thisFamily!)")
            if thisOceanLife.thisFamily! != previouslyCountedFamilly {
                numberOfSubspecies = 0
                countedSpecies = []
                previouslyCountedFamilly = thisOceanLife.thisFamily!
                //print ("previouslyCountedFamilly = \(previouslyCountedFamilly)")
            }
            countSubSpecies(oceanLifeSpecies: thisOceanLife)
            parentSpeciesDictionary[thisOceanLife.thisFamily!] = numberOfSubspecies
        }
        
        //SHOW unique for this parent family
        species = masterFamillies.filter{ $0.thisFamily == parentFamily }
        for thisOceanLife in species {
            if thisOceanLife.thisName != thisOceanLife.thisFamily { //exclude the parent family entry description
                parentSpeciesDictionary[thisOceanLife.thisName!] = 0
            }
        }
        
        sortedParentSpeciesDictionary = parentSpeciesDictionary.sorted(by: { (a, b) in (a.value) > (b.value)}) as! [(specie: String, numberOfSubspecies: Int)]
        print(sortedParentSpeciesDictionary)

        registerCell()
        configureNavigationBar()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
//MARK: Navigation Bar Management
extension FamillyChildCollectionViewController{
    func configureNavigationBar(){
        let backButton = backBtn()
        self.navigationItem.leftBarButtonItems = [backButton]
        
        let searchButton = searchBtn()
        self.navigationItem.rightBarButtonItems = [searchButton]
    }
    func backBtn () -> UIBarButtonItem {
        return OceanLifeUIBarButtonItem().customBackBarButton(target: self, selector: #selector(FamillyChildCollectionViewController.back))
    }
    func searchBtn () -> UIBarButtonItem {
        return OceanLifeUIBarButtonItem().customSearchBarButton(target: self, selector: #selector(FamillyChildCollectionViewController.search))
    }
}


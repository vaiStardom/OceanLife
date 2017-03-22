//
//  SpeciesCollectionViewController.swift
//  OceanLife
//
//  Created by Paul Addy on 3/17/17.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class SpeciesCollectionViewController: UICollectionViewController {
    fileprivate var firstParentFamillies = [OceanLifeSpecies]()
    fileprivate var parentSpeciesDictionary: [String:Int] = [:]
    fileprivate var countedSpecieName: String?
    fileprivate let sectionInsets = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
    fileprivate let itemsPerRow: CGFloat = 2
}
//MARK: Actions
extension SpeciesCollectionViewController{
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        countedSpecies = []
        let famillyChildCollectionViewController = (self.storyboard?.instantiateViewController(withIdentifier: "FamillyChildCollectionViewController"))! as! FamillyChildCollectionViewController
        let key = Array(parentSpeciesDictionary.keys)[indexPath.row]
        famillyChildCollectionViewController.parentFamily = key
        self.navigationController?.pushViewController(famillyChildCollectionViewController, animated: true)
    }
    func add(){
    }
    func search(){
    }
}
//MARK: UICollectionViewDelegateFlowLayout
extension SpeciesCollectionViewController : UICollectionViewDelegateFlowLayout {
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
//MARK: Collection view management
extension SpeciesCollectionViewController{
    fileprivate func registerCell() {
        let nib = UINib(nibName: String(describing: SpecieCollectionViewCell.self), bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: SpecieCollectionViewCell.self))
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return parentSpeciesDictionary.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SpecieCollectionViewCell.self), for: indexPath as IndexPath) as! SpecieCollectionViewCell

        let key = Array(parentSpeciesDictionary.keys)[indexPath.row]
        let array = parentSpeciesDictionary[key]
        cell.specieImageView.image = UIImage(named: "testImage")
        cell.specieNameLabel.text = key
        cell.numberOfSubspeciesLabel.text = "\(array!)"
        
        return cell
    }
}
//MARK: Life-cycle
extension SpeciesCollectionViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstParentFamillies = masterFamillies.filter{ $0.thisParentFamily == nil }
        countedSpecies = []
        for thisOceanLife in firstParentFamillies {
            //print("Will count subspecies of parent family : \(thisOceanLife.thisFamily)")
            countSubSpecies(oceanLifeSpecies: thisOceanLife)
            parentSpeciesDictionary[thisOceanLife.thisFamily!] = numberOfSubspecies
            numberOfSubspecies = 0
            countedSpecies = []
        }
        registerCell()
        configureNavigationBar()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
//MARK: Navigation Bar Management
extension SpeciesCollectionViewController{
    func configureNavigationBar(){
        let addButton = addBtn()
        self.navigationItem.leftBarButtonItems = [addButton]
        
        let searchButton = searchBtn()
        self.navigationItem.rightBarButtonItems = [searchButton]
    }
    func addBtn () -> UIBarButtonItem {
        return OceanLifeUIBarButtonItem().customAddBarButton(target: self, selector: #selector(SpeciesCollectionViewController.add))
    }
    func searchBtn () -> UIBarButtonItem {
        return OceanLifeUIBarButtonItem().customSearchBarButton(target: self, selector: #selector(SpeciesCollectionViewController.search))
    }
}

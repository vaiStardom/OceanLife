//
//  FamillyChildCollectionViewController.swift
//  OceanLife
//
//  Created by Paul Addy on 3/17/17.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class FamillyChildCollectionViewController: UICollectionViewController {
    var referenceSpecieId: Int!
    var childNodes = [OceanLifeSpecieNode]()
    var navigationBarTitle: String!
    
    fileprivate var subSpecies = [OceanLifeSpecies]()
    fileprivate let sectionInsets = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
    fileprivate let itemsPerRow: CGFloat = 2
}
//MARK: Actions
extension FamillyChildCollectionViewController{
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let species = SPECIES.filter{ $0.hashValue == childNodes[indexPath.row].id  }
        let specie = species[0]
        subSpecies = SPECIES.filter{ $0.thisParentFamily == specie.thisName }
        
        if subSpecies.count > 0 {
            let famillyChildCollectionViewController = (self.storyboard?.instantiateViewController(withIdentifier: "FamillyChildCollectionViewController"))! as! FamillyChildCollectionViewController
            famillyChildCollectionViewController.referenceSpecieId = childNodes[indexPath.row].id
            famillyChildCollectionViewController.navigationBarTitle = childNodes[indexPath.row].name
            self.navigationController?.pushViewController(famillyChildCollectionViewController, animated: true)
        } else {
            let specieDetailsViewController = (self.storyboard?.instantiateViewController(withIdentifier: "SpecieDetailsViewController"))! as! SpecieDetailsViewController
            specieDetailsViewController.specieReferenceId = specie.hashValue
            specieDetailsViewController.navigationBarTitle = specie.thisParentFamily
            self.navigationController?.pushViewController(specieDetailsViewController, animated: true)
        }
    }
    func back(){
        _ = self.navigationController?.popViewController(animated: true)
    }
//    func search(){
//    }
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
        return childNodes.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SpecieCollectionViewCell.self), for: indexPath as IndexPath) as! SpecieCollectionViewCell
        
        let oceanLifeSpecie = SPECIES.filter{ $0.hashValue == childNodes[indexPath.row].id }
        cell.specieImageView.image = UIImage(named: (oceanLifeSpecie[0].thisImageNames[0]))
        cell.specieNameLabel.text = oceanLifeSpecie[0].thisName
        cell.numberOfSubspeciesLabel.text = "\(childNodes[indexPath.row].childrenCount())"

        return cell
    }
}
//MARK: Life-cycle
extension FamillyChildCollectionViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let species = SPECIES.filter{ $0.hashValue == referenceSpecieId }
        let specie = species[0]
        subSpecies = SPECIES.filter{ $0.thisParentFamily == specie.thisName }

        for oceanLife in subSpecies {
            var node = OceanLifeSpecieNode(name: oceanLife.thisName!, id: oceanLife.hashValue)
            BUILD_FAMILY_TREE(ofThisNode: &node)
            childNodes.append(node)
        }
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
//        let searchButton = searchBtn()
//        self.navigationItem.rightBarButtonItems = [searchButton]
        self.navigationItem.titleView = OceanLifeUILabel().navigationItemTotleLabel(title: navigationBarTitle)
    }
    func backBtn () -> UIBarButtonItem {
        return OceanLifeUIBarButtonItem().customBackBarButton(target: self, selector: #selector(FamillyChildCollectionViewController.back))
    }
//    func searchBtn () -> UIBarButtonItem {
//        return OceanLifeUIBarButtonItem().customSearchBarButton(target: self, selector: #selector(FamillyChildCollectionViewController.search))
//    }
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

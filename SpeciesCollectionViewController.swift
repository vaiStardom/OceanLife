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
    fileprivate var parentSpeciesDictionary: [Int:Int] = [:]
    fileprivate var countedSpecieName: String?
    fileprivate let sectionInsets = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
    fileprivate let itemsPerRow: CGFloat = 2
}
//MARK: Actions
extension SpeciesCollectionViewController{
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let famillyChildCollectionViewController = (self.storyboard?.instantiateViewController(withIdentifier: "FamillyChildCollectionViewController"))! as! FamillyChildCollectionViewController
        famillyChildCollectionViewController.referenceSpecieId = OCEAN_LIFE_SPECIE_NODES[indexPath.row].id
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
        return OCEAN_LIFE_SPECIE_NODES.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SpecieCollectionViewCell.self), for: indexPath as IndexPath) as! SpecieCollectionViewCell
        let oceanLifeSpecie = SPECIES.filter{ $0.hashValue == OCEAN_LIFE_SPECIE_NODES[indexPath.row].id }
        
        cell.specieImageView.image = UIImage(named: (oceanLifeSpecie[0].thisImageNames[0]))
        cell.specieNameLabel.text = oceanLifeSpecie[0].thisName
        cell.numberOfSubspeciesLabel.text = "\(OCEAN_LIFE_SPECIE_NODES[indexPath.row].childrenCount())"

        return cell
    }
}
//MARK: Life-cycle
extension SpeciesCollectionViewController{
    override func viewDidLoad() {
        super.viewDidLoad()

        firstParentFamillies = SPECIES.filter{ $0.thisParentFamily == nil }
        for oceanLife in firstParentFamillies {
            var node = OceanLifeSpecieNode(name: oceanLife.thisName!, id: oceanLife.hashValue)
            BUILD_FAMILY_TREE(ofThisNode: &node)
            OCEAN_LIFE_SPECIE_NODES.append(node)
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

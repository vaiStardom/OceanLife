//
//  ViewController.swift
//  OceanLife
//
//  Created by Paul Addy on 2016-10-15.
//  Copyright © 2016 Paul Addy. All rights reserved.
//

import expanding_collection
import UIKit

class OceanLifeViewController: ExpandingViewController {
    
    fileprivate var cellsIsOpen = [Bool]()
    var species: [OceanLifeSpecies] = [
        OceanLifeSpecies(name: "Batfish", pictureFile: "Batfish")
        ,OceanLifeSpecies(name: "Coral", pictureFile: "Coral")
        ,OceanLifeSpecies(name: "Cowrie", pictureFile: "Cowrie")
        ,OceanLifeSpecies(name: "Frogfish", pictureFile: "Frogfish")
        ,OceanLifeSpecies(name: "Nudibranch", pictureFile: "Nudibranch")
        ,OceanLifeSpecies(name: "Porcupinefish", pictureFile: "Porcupinefish")
        ,OceanLifeSpecies(name: "ShrimpCoral", pictureFile: "ShrimpCoral")
    ]
}
// MARK: life cycle
extension OceanLifeViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        itemSize = CGSize(width: 208, height: 166)
        registerCell()
        fillCellIsOpenArray()
        addGestureToView(collectionView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
// MARK: Helpers
extension OceanLifeViewController {
    fileprivate func registerCell() {
        let nib = UINib(nibName: String(describing: OceanLifeCollectionViewCell.self), bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: OceanLifeCollectionViewCell.self))
    }
    fileprivate func fillCellIsOpenArray(){
        for _ in species {
            cellsIsOpen.append(false)
        }
    }
    fileprivate func getViewController() -> ExpandingTableViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let toViewController: TestTableViewController = storyboard.instantiateViewController(withIdentifier: "TestTableViewController") as! TestTableViewController
        return toViewController
    }
}
// MARK: Gesture
extension OceanLifeViewController {
    fileprivate func addGestureToView(_ toView: UIView){
        let gestureUp = Init(UISwipeGestureRecognizer(target: self, action: #selector(OceanLifeViewController.swipeHandler(_:)))) {
            $0.direction = .up
        }
        
        let gestureDown = Init(UISwipeGestureRecognizer(target: self, action: #selector(OceanLifeViewController.swipeHandler(_:)))) {
            $0.direction = .down
        }
        toView.addGestureRecognizer(gestureUp)
        toView.addGestureRecognizer(gestureDown)
    }
    func swipeHandler(_ sender: UISwipeGestureRecognizer){
        let indexPath = IndexPath(row: currentIndex, section: 0)
        guard let cell = collectionView?.cellForItem(at: indexPath) as? OceanLifeCollectionViewCell else {return}
        
        //double swipe up transition
        if cell.isOpened == true && sender.direction == .up {
            pushToViewController(getViewController())
        }
        let open = sender.direction == .up ? true : false
        cell.cellIsOpen(open)
        cellsIsOpen[(indexPath as NSIndexPath).row] = cell.isOpened
    }
}
// MARK: UICollectionViewDataSource
extension OceanLifeViewController {
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        super.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
        guard let cell = cell as? OceanLifeCollectionViewCell else { return }
        let index = (indexPath as NSIndexPath).row % species.count
        let specie = species[index]
        
        let oceanLifeImage = UIImage(named: specie.givenPictureFile)
        cell.oceanLifeImageView.image = oceanLifeImage
        cell.oceanLifeNameLabel.text = specie.givenName
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? OceanLifeCollectionViewCell , currentIndex == (indexPath as NSIndexPath).row else {return}
        if cell.isOpened == false {
            cell.cellIsOpen(true)
        } else {
//            pushToViewController(getViewController())
//            if let rightButton = navigationItem.rightBarButtonItem as? AnimatingBarButton{
//                rightButton.animationSelected(true)
//            }
        }
    }
}
// MARK: UICollectionViewDataSource
extension OceanLifeViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return species.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: OceanLifeCollectionViewCell.self), for: indexPath)
    }
}



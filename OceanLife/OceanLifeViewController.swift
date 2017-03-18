//
//  ViewController.swift
//  OceanLife
//
//  Created by Paul Addy on 2016-10-15.
//  Copyright © 2016 Paul Addy. All rights reserved.
//
// endangered species rating website: http://www.iucnredlist.org/details/155097/0
// encyclopedia: http://eol.org/pages/1012924/overview
// explore: http://coralnet.ucsd.edu/about/
// explore: http://creationwiki.org/Lace_coral

import CoreData
import expanding_collection
import UIKit

var OCEANLIFESPECIES: [Species] = []

class OceanLifeViewController: ExpandingViewController {
    fileprivate var cellsIsOpen = [Bool]()
    @IBOutlet weak var oceanLifeTitleLable: UILabel!
    
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache: NSCache<AnyObject, AnyObject>!
}
// MARK: life cycle
extension OceanLifeViewController{
    override func viewDidLoad() {
        itemSize = CGSize(width: 166, height: 208)
        
        super.viewDidLoad()
        
        //empty data
        //OceanLifeSpecies.emptySpecies()
        
        //read data file
        readDataFromFile(file: "data")
        printData()
        
        //Load initial data
//        for item in masterFamillies {
//            if OceanLifeSpecies.isSpecieExist(familly: item.thisFamilly!) == false {
//                OceanLifeSpecies.updateSpecies(species: item)
//            }
//        }
        
        //        OCEANLIFESPECIES = OceanLifeSpecies.getSpecies()
        
        registerCell()
        fillCellIsOpenArray()
        addGestureToView(collectionView!)
        
        session = URLSession.shared
        task = URLSessionDownloadTask()
        self.cache = NSCache()
        
        self.oceanLifeTitleLable.text = "\(OCEANLIFESPECIES[currentIndex].commonName!)"
    }
}
// MARK: Helpers
extension OceanLifeViewController {
    fileprivate func registerCell() {
        let nib = UINib(nibName: String(describing: OceanLifeCollectionViewCell.self), bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: OceanLifeCollectionViewCell.self))
    }
    fileprivate func fillCellIsOpenArray(){
        //for _ in SPECIES {
        for _ in OCEANLIFESPECIES {
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
            OceanLifeUser.sharedInstance.givenCurrentOceanLifeIndex = currentIndex
            pushToViewController(getViewController())
        }
        
        let open = sender.direction == .up ? true : false
        cell.cellIsOpen(open)
        cellsIsOpen[(indexPath as NSIndexPath).row] = cell.isOpened
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.oceanLifeTitleLable.text = "\(OCEANLIFESPECIES[currentIndex].commonName!)"
    }
    
}
// MARK: UICollectionViewDataSource
extension OceanLifeViewController {

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        super.collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
        
        guard let cell = cell as? OceanLifeCollectionViewCell else { return }
        let index = (indexPath as NSIndexPath).row % OCEANLIFESPECIES.count
        let specie = OCEANLIFESPECIES[index]

        //Check if there is an image saved to core data
        if specie.cellImage != nil {
            cell.oceanLifeImageView.image = UIImage(data: specie.cellImage as! Data)
            //print("Core data image used, no need to download it")
            cell.activityIndicatorView.stopAnimating()
        } else {
            cell.oceanLifeImageView.image = UIImage(named: "placeholder")
            let url = URL(string: specie.cellImageLink!)
            cell.activityIndicatorView.startAnimating()
            task = session.downloadTask(with: url!, completionHandler: { (location, response, error) -> Void in
                if let data = try? Data(contentsOf: url!){
                    DispatchQueue.main.async(execute: { () -> Void in
                        if let updateCell = collectionView.cellForItem(at: indexPath) as? OceanLifeCollectionViewCell {
                            let img: UIImage! = UIImage(data: data)
                            updateCell.oceanLifeImageView?.image = img
                            updateCell.activityIndicatorView.stopAnimating()
                            specie.cellImage = UIImagePNGRepresentation(img)! as NSData?
                            //OceanLifeSpecies.updateOceanSpecieCellImage(species: specie)
                            //print("Had to dowload cell image from the web.")
                        }
                    })
                }
            })
            task.resume()
        }
        cell.oceanLifeImageView.contentMode = .scaleAspectFit
        cell.oceanLifeNameLabel.text = specie.familly
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? OceanLifeCollectionViewCell , currentIndex == (indexPath as NSIndexPath).row else {return}
        if cell.isOpened == false {
            cell.cellIsOpen(true)
        } else {
            pushToViewController(getViewController())
        }
    }
}
// MARK: UICollectionViewDataSource
extension OceanLifeViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return OCEANLIFESPECIES.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: OceanLifeCollectionViewCell.self), for: indexPath)
    }
}

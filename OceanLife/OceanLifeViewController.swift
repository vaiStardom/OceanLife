//
//  ViewController.swift
//  OceanLife
//
//  Created by Paul Addy on 2016-10-15.
//  Copyright © 2016 Paul Addy. All rights reserved.
//
// endangered species rating website: http://www.iucnredlist.org/details/155097/0
// encyclopedia: http://eol.org/pages/1012924/overview

import expanding_collection
import UIKit

class OceanLifeViewController: ExpandingViewController {
    fileprivate var cellsIsOpen = [Bool]()
    
    var task: URLSessionDownloadTask!
    var session: URLSession!
    var cache: NSCache<AnyObject, AnyObject>!
}
// MARK: life cycle
extension OceanLifeViewController{
    override func viewDidLoad() {
        itemSize = CGSize(width: 166, height: 208)
        
        super.viewDidLoad()
        
        registerCell()
        fillCellIsOpenArray()
        addGestureToView(collectionView!)
        
        session = URLSession.shared
        task = URLSessionDownloadTask()
        self.cache = NSCache()
    }
}
// MARK: Helpers
extension OceanLifeViewController {
    fileprivate func registerCell() {
        let nib = UINib(nibName: String(describing: OceanLifeCollectionViewCell.self), bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: OceanLifeCollectionViewCell.self))
    }
    fileprivate func fillCellIsOpenArray(){
        for _ in SPECIES {
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
            OceanLifeUser.sharedInstance.givenCurrentOceanLifeIndex = cell.oceanLifeIndex!
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
        let index = (indexPath as NSIndexPath).row % SPECIES.count
        let specie = SPECIES[index]
        
        let url = URL(string: specie.givenCellImageLink)
        cell.oceanLifeImageView.contentMode = .scaleAspectFit
        cell.oceanLifeImageView.image = UIImage(named: "placeholder")
        cell.oceanLifeNameLabel.text = specie.givenName
        cell.oceanLifeIndex = index

        if (self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) != nil ) {
            print("Cached image used, no need to download it")
            cell.oceanLifeImageView.image = self.cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) as? UIImage
        } else {
            cell.activityIndicatorView.startAnimating()
            task = session.downloadTask(with: url!, completionHandler: { (location, response, error) -> Void in
                if let data = try? Data(contentsOf: url!){
                    DispatchQueue.main.async(execute: { () -> Void in
                        if let updateCell = collectionView.cellForItem(at: indexPath) as? OceanLifeCollectionViewCell {
                            let img: UIImage! = UIImage(data: data)
                            updateCell.oceanLifeImageView?.image = img
                            updateCell.activityIndicatorView.stopAnimating()
                            //ToDo: save the image file path in the OceanLifeSpecies object
                            //ToDo: serializer the OceanLifeSpecies array to disk
                            //ToDo: check whether this OceanLifeSpecies already has a saved file on dick before fetching it from the internet
                            self.cache.setObject(img, forKey: (indexPath as NSIndexPath).row as AnyObject)
                        }
                    })
                }
            })
            task.resume()
        }
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
        return SPECIES.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: OceanLifeCollectionViewCell.self), for: indexPath)
    }
}

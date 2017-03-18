//
//  FamillyChildCollectionViewController.swift
//  OceanLife
//
//  Created by Paul Addy on 3/17/17.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FamillyChildCollectionViewController: UICollectionViewController {
    var dataSources = [UIColor]()
}
//MARK: Actions
extension FamillyChildCollectionViewController{
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let famillyChildCollectionViewController = (self.storyboard?.instantiateViewController(withIdentifier: "FamillyChildCollectionViewController"))! as! FamillyChildCollectionViewController
        self.navigationController?.pushViewController(famillyChildCollectionViewController, animated: true)
    }
}
//MARK: Collection view management
extension FamillyChildCollectionViewController{
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
//MARK: Life-cycle
extension FamillyChildCollectionViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSources.append(UIColor.blue)
        dataSources.append(UIColor.blue)
        dataSources.append(UIColor.blue)
        dataSources.append(UIColor.blue)
        dataSources.append(UIColor.blue)
        dataSources.append(UIColor.blue)
        dataSources.append(UIColor.blue)
        dataSources.append(UIColor.blue)
        dataSources.append(UIColor.blue)
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

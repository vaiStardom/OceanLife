//
//  SpecieDetailsViewController.swift
//  OceanLife
//
//  Created by Paul Addy on 4/8/17.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class SpecieDetailsViewController: UIViewController {
    var specieReferenceId: Int?
    var navigationBarTitle: String!
    var specieImage = UIImage()
    
    @IBOutlet weak var specieImageView: UIImageView!
    @IBOutlet weak var specieNameLabel: UILabel!
    @IBOutlet weak var specieNameLatinLabel: UILabel!
    @IBOutlet weak var specieDetailsLabel: UILabel!
}
//MARK: Actions
extension SpecieDetailsViewController{
    func back(){
        _ = self.navigationController?.popViewController(animated: true)
    }
//    func search(){
//    }
    func imageTap(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "SpecieToFullScreen", sender: self)
    }
}
//MARK: Life-cycle
extension SpecieDetailsViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let species = SPECIES.filter{ $0.hashValue == specieReferenceId }
        let specie = species[0]
        specieImage = UIImage(named: specie.thisImageNames[0])!
        specieImageView.image = specieImage
        specieNameLabel.text = specie.thisName
        specieNameLabel.sizeToFit()
        specieNameLatinLabel.text = specie.thisNameLatin
        specieDetailsLabel.text = specie.thisDescription?.replacingOccurrences(of: "/", with: "\n\n")
        specieDetailsLabel.sizeToFit()
        
        addGestureToView(specieImageView)
        configureNavigationBar()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
// MARK: Gesture
extension SpecieDetailsViewController: UIGestureRecognizerDelegate{
    fileprivate func addGestureToView(_ toView: UIView){
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(SpecieDetailsViewController.imageTap(_:)))
        singleTap.delegate = self
        toView.addGestureRecognizer(singleTap)
    }
}
//MARK: Navigation Bar Management
extension SpecieDetailsViewController{
    func configureNavigationBar(){
        let backButton = backBtn()
        self.navigationItem.leftBarButtonItems = [backButton]
//        let searchButton = searchBtn()
//        self.navigationItem.rightBarButtonItems = [searchButton]
        self.navigationItem.titleView = OceanLifeUILabel().navigationItemTotleLabel(title: navigationBarTitle)
    }
    func backBtn () -> UIBarButtonItem {
        return OceanLifeUIBarButtonItem().customBackBarButton(target: self, selector: #selector(SpecieDetailsViewController.back))
    }
//    func searchBtn () -> UIBarButtonItem {
//        return OceanLifeUIBarButtonItem().customSearchBarButton(target: self, selector: #selector(SpecieDetailsViewController.search))
//    }
}
// MARK: Segue management
extension SpecieDetailsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "SpecieToFullScreen") {
            let fullScreenNavController = segue.destination as! UINavigationController
            let fullScreenImageViewController = fullScreenNavController.viewControllers.first as! FullScreenImageViewController
            fullScreenImageViewController.image = specieImage
        }
    }
}


//
//  FullScreenImageViewController.swift
//  OceanLife
//
//  Created by Paul Addy on 4/8/17.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class FullScreenImageViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var imageView: OceanLifeUIImageView!
    
    var image: UIImage!
}
// MARK: Lifecycle
extension FullScreenImageViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        addGestureToView(imageView)
    }
}
// MARK: Gesture
extension FullScreenImageViewController{
    fileprivate func addGestureToView(_ toView: UIView){
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(FullScreenImageViewController.singleTap(_:)))
        singleTap.delegate = self
        toView.addGestureRecognizer(singleTap)
    }
}
// MARK: Actions
extension FullScreenImageViewController {
    func singleTap(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
}

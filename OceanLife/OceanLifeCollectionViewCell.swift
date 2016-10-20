//
//  OceanLifeCollectionViewCell.swift
//  OceanLife
//
//  Created by Paul Addy on 2016-10-17.
//  Copyright © 2016 Paul Addy. All rights reserved.
//

import expanding_collection
import UIKit

class OceanLifeCollectionViewCell: BasePageCollectionCell{
    
    @IBOutlet weak var oceanLifeNameLabel: UILabel!
    @IBOutlet weak var oceanLifeImageView: UIImageView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var oceanLifeIndex: Int?
}
// MARK: WebViewManagement
extension OceanLifeCollectionViewCell {
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if superview != nil {
            
            //let url = URL(string: SPECIES[1].givenCellImageLink)
//            let url = URL(string: SPECIES[oceanLifeIndex!].givenCellImageLink)
//            let data = NSData(contentsOf: url!)
//            let image = UIImage(data: data as! Data)
//            oceanLifeImageView.image = image
//            oceanLifeImageView.contentMode = .scaleAspectFit
            
            
            //activityIndicatorView.superview?.bringSubview(toFront: activityIndicatorView)
        }
    }
    
//    func webViewDidStartLoad(_ webView : UIWebView){
//        activityIndicatorView.startAnimating()
//    }
//    func webViewDidFinishLoad(_ webView : UIWebView){
//        activityIndicatorView.stopAnimating()
//    }
}

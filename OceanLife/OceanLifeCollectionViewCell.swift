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
            
            
            
            activityIndicatorView.superview?.bringSubview(toFront: activityIndicatorView)
        }
    }
    func webViewDidStartLoad(_ webView : UIWebView){
        activityIndicatorView.startAnimating()
    }
    func webViewDidFinishLoad(_ webView : UIWebView){
        activityIndicatorView.stopAnimating()
    }
}

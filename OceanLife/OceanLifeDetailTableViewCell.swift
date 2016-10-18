//
//  OceanLifeDetailTableViewCell.swift
//  OceanLife
//
//  Created by Paul Addy on 2016-10-18.
//  Copyright © 2016 Paul Addy. All rights reserved.
//

import UIKit

class OceanLifeDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var oceanLifeDetailWebView: UIWebView!
    var oceanLifeDetailsUrlString: String! = "https://en.m.wikipedia.org/wiki/Caesio_teres"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
// MARK: Cell formating
extension OceanLifeDetailTableViewCell {
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        let url = URL (string: oceanLifeDetailsUrlString)
        let requestObj = NSURLRequest(url: url!)

        oceanLifeDetailWebView?.loadRequest(requestObj as URLRequest)
        oceanLifeDetailWebView?.clipsToBounds = true
        oceanLifeDetailWebView?.isOpaque = false
        oceanLifeDetailWebView?.backgroundColor = UIColor.clear
        oceanLifeDetailWebView?.isUserInteractionEnabled = true
        oceanLifeDetailWebView?.sizeToFit()
        //oceanLifeDetailWebView.loadHTMLString(oceanLifeDetailsUrl, baseURL: nil)
        oceanLifeDetailWebView?.reload()
        oceanLifeDetailWebView?.scrollView.indicatorStyle = UIScrollViewIndicatorStyle.white
    }
}

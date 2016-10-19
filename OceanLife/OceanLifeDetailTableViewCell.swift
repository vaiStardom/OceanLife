//
//  OceanLifeDetailTableViewCell.swift
//  OceanLife
//
//  Created by Paul Addy on 2016-10-18.
//  Copyright © 2016 Paul Addy. All rights reserved.
//

import UIKit

class OceanLifeDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var url: String!
}
// MARK: WebViewManagement
extension OceanLifeDetailTableViewCell: UIWebViewDelegate {
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if superview != nil {
            let web = UIWebView(frame: CGRect(x:0, y:0, width:320, height:378))
            web.delegate = self
            web.loadRequest(NSURLRequest(url: NSURL(string: url)! as URL) as URLRequest)
            web.isUserInteractionEnabled = true
            self.contentView.addSubview(web)
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

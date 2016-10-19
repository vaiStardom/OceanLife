//
//  TestTableViewController.swift
//  OceanLife
//
//  Created by Paul Addy on 2016-10-17.
//  Copyright © 2016 Paul Addy. All rights reserved.
//

import expanding_collection
import UIKit

class TestTableViewController: ExpandingTableViewController, UIGestureRecognizerDelegate {

    fileprivate var scrollOffSetY: CGFloat = 0
    fileprivate var contentHeights : [CGFloat] = [0.0, 0.0]
    
    var oceanLifeIndex: Int?
    
}

// MARK: Lifecycle
extension  TestTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureTableView()
        addGestureToView(self.view)
    }
}
// MARK: TableView
extension  TestTableViewController: UIWebViewDelegate {
    fileprivate func configureTableView(){
        tableView.register(UINib(nibName: "OceanLifeDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "OceanLifeDetailCell")
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OceanLifeDetailCell") as! OceanLifeDetailTableViewCell
//        let htmlHeight = contentHeights[indexPath.row]
//        cell.oceanLifeDetailWebView?.tag = indexPath.row
//        cell.oceanLifeDetailWebView?.delegate = self
//        cell.oceanLifeDetailWebView?.loadRequest(NSURLRequest(url: NSURL(string: "https://en.m.wikipedia.org/wiki/Caesio_teres")! as URL) as URLRequest)
//        cell.oceanLifeDetailWebView?.frame = CGRect(x: 0, y: 0, width: cell.frame.size.width, height: htmlHeight)
//        cell.oceanLifeDetailWebView?.scrollView.isScrollEnabled = false
//        cell.oceanLifeDetailWebView?.frame = CGRect(x: 0, y: 0, width: cell.frame.size.width, height: htmlHeight)
        
        
        let web = UIWebView(frame: CGRect(x:0, y:0, width:320, height:378))
        //web.loadHTMLString("im a <b>webview</b>", baseURL: nil)
        //web.loadRequest(NSURLRequest(url: NSURL(string: "https://en.m.wikipedia.org/wiki/Caesio_teres")! as URL) as URLRequest)
        web.loadRequest(NSURLRequest(url: NSURL(string: SPECIES[OceanLifeUser.sharedInstance.givenCurrentOceanLifeIndex].givenWikipediaLink)! as URL) as URLRequest)
        web.isUserInteractionEnabled = true
        cell.contentView.addSubview(web)


        
        return cell
    }
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        
        if (contentHeights[webView.tag] == webView.scrollView.contentSize.height)
        {
            
            return
        }
        webView.frame.size.height = 1
        webView.frame.size = webView.sizeThatFits(CGSize.zero)
        contentHeights[webView.tag] = webView.scrollView.contentSize.height
        
        tableView.reloadRows(at: [IndexPath(row: webView.tag, section: 0)], with: .automatic)
    }
}
// MARK: Helper
extension TestTableViewController {
    fileprivate func configureNavBar(){
        navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    }
}
// MARK: Gesture
extension TestTableViewController {
    fileprivate func addGestureToView(_ toView: UIView){
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(TestTableViewController.singleTap(_:)))
        singleTap.delegate = self
        toView.addGestureRecognizer(singleTap)
    }
    func singleTap(_ sender: UITapGestureRecognizer){
        if scrollOffSetY == 0 {
            popTransitionAnimation()
        }
    }
    @objc(gestureRecognizer:shouldReceiveTouch:) func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let point = touch.location(in: self.view)
        if point.y <= 190 && scrollOffSetY == 0 {
            return true
        }
        return false
    }
}
// MARK: Actions
extension TestTableViewController {
    @IBAction func backButtonHandler(_ sender: AnyObject){
        popTransitionAnimation()
    }
}
// MARK: UIScrollViewDelegate
extension TestTableViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollOffSetY = scrollView.contentOffset.y
    }
}


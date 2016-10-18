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
    fileprivate var masterpieceIndex: Int?
}

// MARK: Lifecycle
extension  TestTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        addGestureToView(self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}
// MARK: TableView
extension  TestTableViewController {
    fileprivate func configureTableView(){
        tableView.register(UINib(nibName: "OceanLifeDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "OceanLifeDetailCell")
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OceanLifeDetailCell") as! OceanLifeDetailTableViewCell
        
        let url = NSURL (string: "https://en.m.wikipedia.org/wiki/Caesio_teres");
        let requestObj = NSURLRequest(url: url! as URL);
        cell.oceanLifeDetailWebView.loadRequest(requestObj as URLRequest);
        
        return cell
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
        if point.y <= 240 && scrollOffSetY == 0 {
            return true
        }
        return false
    }
}
// MARK: UIScrollViewDelegate
extension TestTableViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollOffSetY = scrollView.contentOffset.y
    }
}


//
//  OceanLifeUIBarButtonItem.swift
//  OceanLife
//
//  Created by Paul Addy on 3/20/17.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class OceanLifeUIBarButtonItem: UIBarButtonItem {

    func customAddBarButton(target: UIViewController, selector: Selector) -> UIBarButtonItem {
        return customAddBarButton(imageNamed:NAVBAR_ADDICON, frame: NAVBAR_ADDICON_CGRECT, target: target, selector: selector)
    }
    func customBackBarButton(target: UIViewController, selector: Selector) -> UIBarButtonItem {
        return customBackButton(imageNamed:NAVBAR_BACKICON, frame: NAVBAR_BACKICON_CGRECT, target: target, selector: selector)
    }
    func customSearchBarButton(target: UIViewController, selector: Selector) -> UIBarButtonItem {
        return customAddSearchButton(imageNamed:NAVBAR_SEARCHICON, frame: NAVBAR_SEARCHICON_CGRECT, target: target, selector: selector)
    }
    func customAddBarButton(imageNamed:String, frame: CGRect, target: UIViewController, selector: Selector, notifications: Int = 0) -> UIBarButtonItem {
        
        let imageView = UIImageView(frame:NAVBAR_ADDICON_IMAGE_CGRECT)
        imageView.image = UIImage(named: imageNamed)
        
        let button = UIButton(frame: frame)
        button.addTarget(target, action: selector, for: .touchUpInside)
        
        let view = UIView(frame: frame)

        imageView.center = CGPoint(x: (view.frame.size.width / 2) - 15, y: view.frame.size.height / 2)
        
        view.addSubview(imageView)
        view.addSubview(button)
        
        return UIBarButtonItem(customView: view)
    }
    func customAddSearchButton(imageNamed:String, frame: CGRect, target: UIViewController, selector: Selector, notifications: Int = 0) -> UIBarButtonItem {
        
        let imageView = UIImageView(frame:NAVBAR_SEARCHICON_IMAGE_CGRECT)
        imageView.image = UIImage(named: imageNamed)
        
        let button = UIButton(frame: frame)
        button.addTarget(target, action: selector, for: .touchUpInside)
        
        let view = UIView(frame: frame)
        
        imageView.center = CGPoint(x: (view.frame.size.width / 2) - 15, y: view.frame.size.height / 2)
        
        view.addSubview(imageView)
        view.addSubview(button)
        
        return UIBarButtonItem(customView: view)
    }
    func customBackButton(imageNamed:String, frame: CGRect, target: UIViewController, selector: Selector, notifications: Int = 0) -> UIBarButtonItem {
        
        let imageView = UIImageView(frame:NAVBAR_BACKICON_IMAGE_CGRECT)
        imageView.image = UIImage(named: imageNamed)
        
        let button = UIButton(frame: frame)
        button.addTarget(target, action: selector, for: .touchUpInside)
        
        let view = UIView(frame: frame)
        
        imageView.center = CGPoint(x: (view.frame.size.width / 2) - 15, y: view.frame.size.height / 2)
        
        view.addSubview(imageView)
        view.addSubview(button)
        
        return UIBarButtonItem(customView: view)
    }

}

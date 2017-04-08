//
//  OceanLifeUILabel.swift
//  OceanLife
//
//  Created by Paul Addy on 4/8/17.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class OceanLifeUILabel: UILabel {

    func navigationItemTotleLabel(title: String) -> UILabel {
        
        var mutableAttributedString = NSMutableAttributedString()
        mutableAttributedString = NSMutableAttributedString(string: title, attributes: [
            NSFontAttributeName:UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
            , NSForegroundColorAttributeName: OceanLifeColor.RedOrange
            ])
        
        var titleLabel = UILabel()
        titleLabel.attributedText = mutableAttributedString
        titleLabel.sizeToFit()

        return titleLabel
    }
}

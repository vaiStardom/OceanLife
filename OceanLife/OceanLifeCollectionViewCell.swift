//
//  OceanLifeCollectionViewCell.swift
//  OceanLife
//
//  Created by Paul Addy on 2016-10-17.
//  Copyright © 2016 Paul Addy. All rights reserved.
//

import expanding_collection
import UIKit

class OceanLifeCollectionViewCell: BasePageCollectionCell, UIWebViewDelegate {
    
    @IBOutlet weak var oceanLifeNameLabel: UILabel!
    @IBOutlet weak var oceanLifeImageView: UIImageView!
    
    var oceanLifeIndex: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

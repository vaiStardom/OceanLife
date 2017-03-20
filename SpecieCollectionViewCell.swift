//
//  SpecieCollectionViewCell.swift
//  OceanLife
//
//  Created by Paul Addy on 3/18/17.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class SpecieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var specieImageView: UIImageView!
    
    @IBOutlet weak var specieNameLabel: UILabel!
    @IBOutlet weak var numberOfSubspeciesLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

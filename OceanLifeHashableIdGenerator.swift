//
//  OceanLifeHashableIdGenerator.swift
//  OceanLife
//
//  Created by Paul Addy on 4/1/17.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

class OceanLifeHashableIdGenerator {
    private var nextId = 0
    func generate() -> Int {
        nextId += 1
        return nextId
    }
}

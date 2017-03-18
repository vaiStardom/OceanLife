//
//  OceanLifeProtocolExtensions.swift
//  OceanLife
//
//  Created by Paul Addy on 3/17/17.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

extension Array {
    /// GroupBy that puts each element into a group of similiar elements denoted by an Equatable attribut, complexity: O(n)
    func group<G: Equatable>(by grouping: (Element) -> (G)) -> [G: [Element]] {
        return reduce([:], { (result, element) in
            var groups = result
            let group = grouping(element)
            
            if let existingGroupElements = groups[group] {
                groups[group] = existingGroupElements + [element]
            } else {
                groups[group] = [element]
            }
            
            return groups
        })
    }
}

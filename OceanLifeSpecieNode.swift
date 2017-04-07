//
//  OceanLifeSpecieNode.swift
//  OceanLife
//
//  Created by Paul Addy on 4/7/17.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import Foundation

class OceanLifeSpecieNode {
    var name: String
    var id: Int
    weak var parentSpecie: OceanLifeSpecieNode?
    var children: [OceanLifeSpecieNode] = []
    var numberOfChildren = 0
    
    init(name: String, id: Int){
        self.name = name
        self.id = id
    }
    
    func add(child: OceanLifeSpecieNode){
        children.append(child)
        child.parentSpecie = self
    }
}
extension OceanLifeSpecieNode: CustomStringConvertible {
    var description: String {
        var text = "\(name)"
        if !children.isEmpty {
            text += " {" + children.map { $0.description }.joined(separator: ", ") + "} "
        }
        return text
    }
}
extension OceanLifeSpecieNode {
    func search(name: String) -> OceanLifeSpecieNode? {
        if name == self.name {
            return self
        }
        for child in children {
            if let found = child.search(name: name) {
                return found
            }
        }
        return nil
    }
    func search(id: Int) -> OceanLifeSpecieNode? {
        if id == self.id {
            return self
        }
        for child in children {
            if let found = child.search(id: id) {
                return found
            }
        }
        return nil
    }
}
extension OceanLifeSpecieNode {
    func childrenCount() -> Int {
        numberOfChildren = self.children.count
        for child in children {
            numberOfChildren += child.childrenCount()
        }
        return numberOfChildren
    }
}

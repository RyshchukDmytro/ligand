//
//  Relation.swift
//  SwiftProtein
//
//  Created by Nazar Prysiazhnyi on 10/12/19.
//  Copyright © 2019 Dmytro Ryshchuk. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

struct Relation {
    let start: SCNVector3
    let finish: SCNVector3
    func getDistance() -> Float {
        let x = finish.x - start.x
        let y = finish.y - start.y
        let z = finish.z - start.z
        return sqrtf(powf(x, 2.0) + powf(y, 2.0) + powf(z, 2.0))
    }
}


struct AtomOne {
    let name: String
    let color: UIColor
    let x: Double
    let y: Double
    let z: Double
    
    init?(text: [String]) {
        if text.count < 11 {
            return nil
        }
        self.name = text[11]
        self.x = Double(text[6])!
        self.y = Double(text[7])!
        self.z = Double(text[8])!
        self.color = Elements.init(rawValue: text[11])?.introduce() ?? .black
    }
}

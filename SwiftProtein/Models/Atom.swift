//
//  Atom.swift
//  SwiftProtein
//
//  Created by Nazar Prysiazhnyi on 10/12/19.
//  Copyright © 2019 Dmytro Ryshchuk. All rights reserved.
//

import Foundation
import UIKit
import SceneKit

struct Atom {
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

extension SCNNode {
    static func lineNode(from: simd_float3, to: simd_float3, radius : CGFloat = 0.25) -> SCNNode
    {
        let vector = to - from
        let height = simd_length(vector)
        
        //cylinder
        let cylinder = SCNCylinder(radius: radius, height: CGFloat(height))
        cylinder.firstMaterial?.diffuse.contents = UIColor.white
        
        //line node
        let lineNode = SCNNode(geometry: cylinder)
        
        //adjust line position
        let line_axis = simd_float3(0, height/2, 0)
        lineNode.simdPosition = from + line_axis
        
        let vector_cross = simd_cross(line_axis, vector)
        let qw = simd_length(line_axis) * simd_length(vector) + simd_dot(line_axis, vector)
        let q = simd_quatf(ix: vector_cross.x, iy: vector_cross.y, iz: vector_cross.z, r: qw).normalized
        
        lineNode.simdRotate(by: q, aroundTarget: from)
        return lineNode
    }
}

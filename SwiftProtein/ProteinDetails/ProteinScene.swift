//
//  ProteinScene.swift
//  SwiftProtein
//
//  Created by Nazar Prysiazhnyi on 10/12/19.
//  Copyright © 2019 Dmytro Ryshchuk. All rights reserved.
//

import UIKit
import SceneKit

class ProteinScene: SCNScene {
    
    private var cameraNode: SCNNode!
    private var atoms: [SCNNode] = []
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(pdbFile: String) {
        super.init()
        let lines = makeLines(text: pdbFile)
        for line in lines {
            let words = makeWorks(line: line)
            guard words.count > 1 else { continue }
            switch words[0] {
            case "ATOM": createAtom(words: words)
            case "CONECT": createRelation(words: words)
            default: break
            }
        }
        setUpCamera()
        createMolecular()
    }
    
    // TODO: make better
    private func setUpCamera() {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        
        var xMin: Float = atoms[0].position.x
        var xMax: Float = atoms[0].position.x
        var yMin: Float = atoms[0].position.y
        var yMax: Float = atoms[0].position.y
        var zMax: Float = atoms[0].position.z
        
        for el in atoms {
            
            if xMin > el.position.x {
                xMin = el.position.x
            }
            if xMax < el.position.x {
                xMax = el.position.x
            }
            
            if yMin > el.position.y {
                yMin = el.position.y
            }
            if yMax < el.position.y {
                yMax = el.position.y
            }
            
            if zMax < el.position.z {
                zMax = el.position.z
            }
        }
        
        cameraNode.position = SCNVector3(x: (xMin + xMax) / 2, y: (yMin + yMax) / 2, z: zMax + 40)
        self.rootNode.addChildNode(cameraNode)
    }
    
    private func makeLines(text: String) -> [String] {
       return text.components(separatedBy: .newlines)
    }
    
    private func makeWorks(line: String) -> [String] {
        return line.split(separator: " ").compactMap{String($0)}
    }
    
    private func createAtom(words: [String]) {
        guard let atom = AtomOne(text: words) else { return }
        let sphereGeometry = SCNSphere(radius: 0.3)
        sphereGeometry.firstMaterial?.diffuse.contents = atom.color
        let sphereNode = SCNNode(geometry: sphereGeometry)
        sphereNode.position = SCNVector3(atom.x, atom.y, atom.z)
        sphereNode.name = atom.name
        atoms.append(sphereNode)
        self.rootNode.addChildNode(sphereNode)
    }
    
    private func createRelation(words: [String]) {
        let conection: [Int] = words.compactMap{Int($0)}
        guard let first = conection.first, atoms.count > first else { return }
        print("conection : \(conection)")
        for conect in 1..<conection.count {
            let relation = Relation(start: atoms[first].position, finish: atoms[conect].position)
            print("cylinder : \(relation.start.x) - \(relation.finish.x), \(relation.getDistance())")
        }
    }
    
    private func createMolecular() {
        self.background.contents = UIColor(red: 59/255, green: 73/255, blue: 91/255, alpha: 1.0)
    }
}

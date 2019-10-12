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
    private var atoms: [SCNNode?] = []
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(pdbFile: String) {
        super.init()
        setUpCamera()
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
        createMolecular()
    }
    
    private func setUpCamera() {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 20, y: 25, z: 0)
        self.rootNode.addChildNode(cameraNode)
    }
    
    private func makeLines(text: String) -> [String] {
       return text.components(separatedBy: "\n")
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
       
    }
    
    private func createMolecular() {
        self.background.contents = UIColor(red: 59/255, green: 73/255, blue: 91/255, alpha: 1)
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

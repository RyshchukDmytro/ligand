//
//  ProteinDetailsVC.swift
//  SwiftProtein
//
//  Created by Dmytro Ryshchuk on 10/12/19.
//  Copyright © 2019 Dmytro Ryshchuk. All rights reserved.
//

import UIKit
import SceneKit

class ProteinDetailsVC: UIViewController {
    
    private var proteinScene: SCNView!
    var pdbFile: String?
    var name: String?
    
    private var currentNode: SCNNode?
    private var previousNodeColor: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()
        proteinScene = SCNView(frame: self.view.frame)
        proteinScene.backgroundColor = .white
        proteinScene.allowsCameraControl = true
        proteinScene.showsStatistics = true
        guard let pdbFile = pdbFile else { return }
        proteinScene.scene = ProteinScene(pdbFile: pdbFile)
        self.view.addSubview(proteinScene)
        navigationItem.title = name
        // like a Viber Big Name 
        navigationItem.largeTitleDisplayMode = .always
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let hitTouch = touches.first else { return }
        
        let location = hitTouch.location(in: proteinScene)
        let hitList = proteinScene.hitTest(location, options: nil)
        
        DispatchQueue.main.async {
            guard let hitNode = hitList.first?.node, hitNode.name != "CONECT" else {
                print("Select node change color: ")
                self.currentNode?.geometry?.firstMaterial?.diffuse.contents = self.previousNodeColor
                return
            }
            if touches.count == 1 {
                print("Select node: \(hitNode.name)")
                
                self.currentNode?.geometry?.firstMaterial?.diffuse.contents = self.previousNodeColor
                self.currentNode = hitNode
                self.previousNodeColor = hitNode.geometry?.firstMaterial?.diffuse.contents as? UIColor
                self.currentNode?.geometry?.firstMaterial?.diffuse.contents = self.previousNodeColor?.withAlphaComponent(0.5)
            }
        }
    }
}
